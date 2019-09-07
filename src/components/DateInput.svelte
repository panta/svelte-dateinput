<script>
    import { createEventDispatcher } from 'svelte';

    import dayjs from 'dayjs';
    import utc from 'dayjs/plugin/utc'
    import customParseFormat from 'dayjs/plugin/customParseFormat'

    import { isString, isArray } from 'lodash-es';

    dayjs.extend(customParseFormat);
    dayjs.extend(utc);

    export let format = [
        "DD/MM/YYYY HH:mm:ss", "DD-MM-YYYY HH:mm:ss",
		"DD/MM/YYYY HH:mm", "DD-MM-YYYY HH:mm",
		"DD/MM/YYYY", "DD-MM-YYYY"
	];
    export let outputFormat = isArray(format) ? format[0] : format;
    export let value = new Date();
	export let inputText = formatDate(value);
    export let formatted = formatDate(value);
    export let valid = false;
	export let classes = '';
	export let placeholder = outputFormat;
	export let useUtc = true;
	export let errorClass = 'is-danger';
	export let validClass = '';

	let oldValue = value;

    const dispatch = createEventDispatcher();

	// return an {val: OBJ, ok: OK} object, where OBJ is a dayjs object
	function parseDate(dt) {
	    let formats = isArray(format) ? format : [format];

	    if (dt == null) {
	        return { val: null, ok: false };
		}

        const dayjsFn = useUtc ? dayjs.utc : dayjs;
	    let dateValue = null;

	    if (isString(dt)) {
	        if (dt === "") {
	            return { val: null, ok: false };
			}
	        for (let i = 0; i < formats.length; i++) {
                dateValue = dayjsFn(dt, formats[i]);
                if (dateValue.isValid())
                    break;
			}
		} else {
			dateValue = dayjsFn(dt);
		}
        return { val: dateValue, ok: dateValue.isValid() }
	}

	// return a string representation
	function formatDate(dt) {
        let formats = isArray(format) ? format : [format];

	    if (dt == null) {
	        return ""
		}
        if (isString(dt)) {
            return dt;
        }
        if (!dt.isValid()) {
            return "";
		}
		return dayjs(dt).format(formats[0]);
	}

	function isValidDate(dt) {
        const { val, ok } = parseDate(dt);
	    return ok;
	}

    $: if (value != oldValue) {
	    // normalize date
        const { val: newValue, ok } = parseDate(value);
		value = newValue;
		valid = ok;

        oldValue = value;
        formatted = formatDate(value);
        if (value && valid) {
            if (formatted != inputText) {
                inputText = formatted;
            }
		}

        dispatch('dateinput', {
            kind: 'changed',
            value: value,
            formatted: formatted,
			valid: valid,
        });
    }

    function onChange(e) {
        const { val: newValue, ok } = parseDate(inputText);
        // value = newValue;
        if (inputText && ok) {
            value = newValue;
            valid = true;
		} else {
            valid = false;
		}
	}

	function validate(dtText) {
        const { val: newValue, ok } = parseDate(dtText);
        return ok;
	}
</script>

<style>
</style>

<input class="input {classes} {(!validate(inputText)) ? errorClass : validClass}"
	   type="text"
	   placeholder="{placeholder}"
	   on:change={onChange}
	   bind:value={inputText}>
