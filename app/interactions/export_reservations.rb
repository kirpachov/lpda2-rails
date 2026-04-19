# frozen_string_literal: true

require "rubyXL"
require "rubyXL/convenience_methods"

# Export menu in xlsx file.
class ExportReservations < ActiveInteraction::Base
  OUTPUT_FILE = Rails.root.join("tmp/reservations-#{Time.now.to_i}.xlsx").to_s
  interface :reservations, methods: %i[to_sql each], default: -> { Reservation.all }

  def execute
    @default_sheet_name = workbook.worksheets.map(&:sheet_name).first
    write_all(foc_sheet("Prenotazioni"))

    workbook.worksheets.filter! { |s| s.sheet_name != @default_sheet_name }

    workbook.write(OUTPUT_FILE)

    OUTPUT_FILE
  end

  def write_all(sheet)
    write_row(sheet, 0, %w[
                id fullname datetime children adults
                email phone table notes status secret
                created_at updated_at
                payment_hpp_url payment_value payment_status
              ])

    index = 0
    reservations.find_each do |reservation|
      write_row(sheet, index + 1,
                [reservation.id, reservation.fullname, ft(reservation.datetime), reservation.children, reservation.adults,
                 reservation.email, reservation.phone, reservation.table, reservation.notes, reservation.status, reservation.secret,
                 ft(reservation.created_at), ft(reservation.updated_at),
                 reservation.payment&.hpp_url, reservation.payment&.value, reservation.payment&.status].flatten)
      index += 1
    end
  end

  private

  def format_time(time)
    I18n.l(time.in_time_zone(Config.app[:restaurant_location_time_zone]), format: "%e/%m/%Y %k:%M").strip
  end
  alias :ft :format_time

  def workbook
    @workbook ||= RubyXL::Workbook.new
  end

  def foc_sheet(name)
    workbook.add_worksheet(name) if workbook[name].nil?

    workbook[name]
  end

  def write(sheet, x_start, y_start, data)
    data.each_with_index do |d, index|
      sheet.insert_cell(x_start, y_start + index, d)
    end
  end

  def write_row(sheet, x_start, data)
    write(sheet, x_start, 0, data)
  end
end
