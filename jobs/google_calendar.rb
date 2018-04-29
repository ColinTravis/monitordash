require 'icalendar'

ical_url = 'https://calendar.google.com/calendar/ical/colintrav%40gmail.com/private-d2599d68759bd42c0c7e9f0b6b528c81/basic.ics'
uri = URI ical_url

SCHEDULER.every '15s', :first_in => 4 do |job|
  result = Net::HTTP.get uri
  calendars = Icalendar::Calendar.parse(result)
  calendar = calendars.first

  events = calendar.events.map do |event|
    {
      start: event.dtstart,
      end: event.dtend,
      summary: event.summary
    }
  end.select { |event| event[:start] > DateTime.now }

  events = events.sort { |a, b| a[:start] <=> b[:start] }

  events = events[0..5]

  send_event('google_calendar', { events: events })
end
