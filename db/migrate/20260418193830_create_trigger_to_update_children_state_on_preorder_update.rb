# frozen_string_literal: true

class CreateTriggerToUpdateChildrenStateOnPreorderUpdate < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<~SQL.squish
          CREATE OR REPLACE FUNCTION propagate_group_status_to_dates()
          RETURNS trigger AS $$
          BEGIN
            UPDATE preorder_reservation_dates
            SET group_status = NEW.status
            WHERE group_id = NEW.id;

            RETURN NEW;
          END;
          $$ LANGUAGE plpgsql;

          CREATE OR REPLACE FUNCTION propagate_group_status_to_turns()
          RETURNS trigger AS $$
          BEGIN
            UPDATE preorder_reservation_groups_to_turns
            SET preorder_reservation_group_status = NEW.status
            WHERE preorder_reservation_group_id = NEW.id;

            RETURN NEW;
          END;
          $$ LANGUAGE plpgsql;

          CREATE TRIGGER trg_propagate_group_status_to_dates
          AFTER UPDATE OF status
          ON preorder_reservation_groups
          FOR EACH ROW
          WHEN (OLD.status IS DISTINCT FROM NEW.status)
          EXECUTE FUNCTION propagate_group_status_to_dates();

          CREATE TRIGGER trg_propagate_group_status_to_turns
          AFTER UPDATE OF status
          ON preorder_reservation_groups
          FOR EACH ROW
          WHEN (OLD.status IS DISTINCT FROM NEW.status)
          EXECUTE FUNCTION propagate_group_status_to_turns();
        SQL
      end

      dir.down do
        execute <<~SQL.squish
          DROP TRIGGER IF EXISTS trg_propagate_group_status_to_dates ON preorder_reservation_groups;
          DROP TRIGGER IF EXISTS trg_propagate_group_status_to_turns ON preorder_reservation_groups;

          DROP FUNCTION IF EXISTS propagate_group_status_to_dates();
          DROP FUNCTION IF EXISTS propagate_group_status_to_turns();
        SQL
      end
    end
  end
end
