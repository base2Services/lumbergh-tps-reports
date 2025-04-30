query "public_access_trend" {
  title       = "Public access trend (last 30 days)"
  description = "Shows the trend of public access issues over the last 30 days."
  
  sql = <<-EOQ
    with dates as (
      select generate_series(
        current_date - interval '30 days',
        current_date,
        interval '1 day'
      )::date as date
    ),
    -- This is a mock trend since we don't have historical data
    -- In a real scenario, you would use CloudTrail logs or other historical data
    mock_data as (
      select 
        date,
        0 as count
      from 
        dates
    )
    
    select
      to_char(date, 'YYYY-MM-DD') as date,
      count
    from
      mock_data
    order by
      date
  EOQ

  tags = {
    service = "AWS"
    type    = "Trend"
  }
}
