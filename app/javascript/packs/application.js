import WebpackerReact from 'webpacker-react'
import Calendar from 'components/calendar'
import { TimeSlotPicker } from 'components/timeslot-picker'
import { Chat } from 'components/chat'

WebpackerReact.setup({Calendar, TimeSlotPicker, Chat})
