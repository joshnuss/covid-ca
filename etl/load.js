import csv from 'csv-parser'
import fs from 'fs'
import pkg from 'pg'
const { Client } = pkg

const provinceMap = {
  'Ontario': 'ON',
  'Quebec': 'QC',
  'Alberta': 'AB',
  'Saskatchewan': 'SK',
  'Manitoba': 'MB',
  'Nova Scotia': 'NS',
  'New Brunswick': 'NB',
  'Yukon': 'YK',
  'Nunavut': 'NU',
  'NWT': 'NW',
  'PEI': 'PEI',
  'BC': 'BC',
  'NL': 'NL',
}

const client = new Client({
  user: 'postgres',
  password: 'postgres',
  database: 'covid_ca'
})

async function parseCsv(path, handler) {
  let rows = []
  return new Promise((resolve) => {
    fs.createReadStream(path)
      .pipe(csv())
      .on('data', row => rows.push(row))
      .on('end', () => resolve(rows))
  })
}

async function importCases() {
  console.log('Importing cases...')
  const rows = await parseCsv('data/cases_timeseries_prov.csv')

  for (let row of rows) {
    const values = [provinceMap[row.province], row.date_report, Number(row.cases)]

    await client.query('INSERT INTO timeseries (province, date, cases) VALUES ($1, $2, $3) ON CONFLICT (province, date) DO UPDATE SET cases=$3', values)
  }
}

async function importActive() {
  console.log('Importing active...')
  const rows = await parseCsv('data/active_timeseries_prov.csv')

  for (let row of rows) {
    const values = [provinceMap[row.province], row.date_active, Number(row.active_cases)]

    await client.query('INSERT INTO timeseries (province, date, active) VALUES ($1, $2, $3) ON CONFLICT (province, date) DO UPDATE SET active=$3', values)
  }
}

async function importDeaths() {
  console.log('Importing deaths...')
  const rows = await parseCsv('data/mortality_timeseries_prov.csv')

  for (let row of rows) {
    const values = [provinceMap[row.province], row.date_death_report, Number(row.deaths)]

    await client.query('INSERT INTO timeseries (province, date, deaths) VALUES ($1, $2, $3) ON CONFLICT (province, date) DO UPDATE SET deaths=$3', values)
  }
}

await client.connect()
await client.query("SET DATESTYLE = iso, dmy")

await importCases()
await importActive()
await importDeaths()

console.log('Done.')

await client.end()
