import {createWriteStream} from 'fs'
import {pipeline} from 'stream'
import {promisify} from 'util'
import fetch from 'node-fetch'

const streamPipeline = promisify(pipeline)

async function downloadFile(url, destination) {
  const response = await fetch(url)

  if (!response.ok) throw new Error(`unexpected response ${response.statusText}`)

  await streamPipeline(response.body, createWriteStream(destination))
}

const files = [
  'active_timeseries_prov.csv',
  'cases_timeseries_prov.csv',
  'mortality_timeseries_prov.csv',
  'recovered_timeseries_prov.csv',
  'testing_timeseries_prov.csv'
]

files.forEach(async file => {
  await downloadFile(`https://github.com/ccodwg/Covid19Canada/raw/master/timeseries_prov/${file}`, `data/${file}`)
})
