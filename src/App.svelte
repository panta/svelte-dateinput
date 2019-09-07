<script>
  import {DateInput} from "./components/components.module";

  let utc = false;
  let date = null;
  let formattedDate;

  let formats = ["DD/MM/YYYY", "DD-MM-YYYY"];

  function onDateInput(e) {
    console.log("onDateInput detail:", e.detail);
  }
</script>

<style>
</style>

<h2>Mostly defaults</h2>

<DateInput bind:value={date}
           bind:formatted={formattedDate}
           useUtc={utc}></DateInput>

<dl>
  <dt>Raw date 1</dt>
  <dd>{date}</dd>
  <dt>Formatted date 1</dt>
  <dd>{formattedDate}</dd>
</dl>

<h2>Some customizations</h2>

<DateInput bind:value={date}
           bind:formatted={formattedDate}
           placeholder="Write a date..."
           useUtc={utc}></DateInput>

<h2>More customizations</h2>

<DateInput format={formats}
           outputFormat="DD-MM-YYYY"
           bind:value={date}
           bind:formatted={formattedDate}
           useUtc={utc} on:dateinput={onDateInput}></DateInput>
