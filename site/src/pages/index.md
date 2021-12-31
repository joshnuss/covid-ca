<script>
  import { lightFormat } from 'date-fns'
</script>

# Covid in Canada

```updated
select max(date) as last_date
    from timeseries
```

*Last update*: <Value data={data.updated} column=last_date fmt=date/>

## Total cases

```total_cases
select sum(cases) as total
    from timeseries
```

<div class="total">
    <Value
        data={data.total_cases}
        column=total
        />
</div>

## Total deaths

```deaths
select sum(deaths) as total
    from timeseries
```

<div class="total death">
    <Value
        data={data.deaths}
        column=total
        />
</div>

## Death rate

<div class="total">
    1:{Math.round(data.total_cases[0].total/data.deaths[0].total)} cases
</div>

## Cases reported by date

```cases_by_date
select date, sum(cases) as total
    from timeseries
    group by date
    order by date
```

<LineChart data={data.cases_by_date} x=date y=total/>

## Deaths reported by date

```deaths_by_date
select date, sum(deaths) as total
    from timeseries
    group by date
    order by date
```

<LineChart data={data.deaths_by_date} x=date y=total/>

## Active cases by date

```active_by_date
select date, sum(active) as total
    from timeseries
    group by date
    order by date
```

<AreaChart data={data.active_by_date} x=date y=total/>

## Death rate by date

```death_rate_by_date
select date, 
case when sum(deaths) > 0 then sum(deaths)::decimal/sum(cases)::decimal else 0 end as rate_pct
    from timeseries
    group by date
    order by date
```

<LineChart data={data.death_rate_by_date} x=date y=rate_pct fmt=pct/>

## Cases by province

```by_province
select provinces.name as province, sum(cases) as cases, sum(deaths) as deaths,
    case when sum(deaths) > 0 then concat('1 in ', (sum(cases)/sum(deaths))::varchar, ' cases') else '--' end as case_death_rate,
    case when sum(deaths) > 0 then concat('1 in ', to_char(provinces.population/sum(deaths), 'fm999G999'), ' people') else '--' end as death_per_capita
    from timeseries inner join provinces on timeseries.province = provinces.code
    group by provinces.name, provinces.population
    order by cases desc
```

<DataTable
    data={data.by_province}
    rows={data.by_province.length}
    />

<style>
    .total {
        font-size: 4rem;
        font-weight: bold;
    }
    .total.death {
        color: tomato
    }
</style>
