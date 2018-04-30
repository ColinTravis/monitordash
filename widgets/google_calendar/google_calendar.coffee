class Dashing.GoogleCalendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events...

    start = moment(event.start)
    end = moment(event.end)

    end_minutes = end.format('mm')
    end_hour = end.format('HH')
    end_hour = if end_hour > 12 then end_hour - 12 else if end_hour < 1 then end_hour = 12 else end_hour
    end_prepand = if end_hour >= 12 then ' PM '  else ' AM '

    start_minutes = start.format('mm')
    hour = start.format('HH')
    prepand = if hour >= 12 then ' PM '  else ' AM '
    hour = if hour > 12 then hour - 12 else if hour < 1 then hour = 12 else hour

    @set('event',event)
    @set('event_date', start.format('dddd Do MMMM'))
    @set('event_times', hour + ':' + start_minutes + prepand + " - " + end_hour + ':' + end_minutes + end_prepand)



    next_events = []
    for next_event in rest
      start = moment(next_event.start)
      start_date = start.format('Do MMM')
      start_hour = start.format('HH')
      start_minutes = start.format('mm')
      start_time = start.format('HH:mm')

      hour = start.format('HH')
      prepand = if hour >= 12 then ' PM '  else ' AM '
      hour = if hour > 12 then hour - 12 else if hour < 1 then hour = 12 else hour

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: hour + ':' + start_minutes + prepand  }


    @set('next_events', next_events)
