module QueryHelper
    # DOCU: Query single record
    # Triggered by: Queries from different models
    # Requires: sql_statement - SELECT
    # Returns: {"id"=>1, "title"=>"Title"}
    # Last updated at: July 15, 2022
    # Owner: Adrian
    def query_record(sql_statement)
        ActiveRecord::Base.connection.select_one(
            ActiveRecord::Base.send(:sanitize_sql_array, sql_statement)
        )
    end

    # DOCU: Query multiple records
    # Triggered by: Queries from different models
    # Requires: sql_statement - SELECT
    # Returns: [{"id"=>1, "title"=>"Title"}, {"id"=>2, "title"=>"Title2"}]
    # Last updated at: July 21, 2022
    # Owner: Adrian
    def query_records(sql_statement)
        ActiveRecord::Base.connection.exec_query(
            ActiveRecord::Base.send(:sanitize_sql_array, sql_statement)
        )
    end

    # DOCU: Insert records to the database
    # Triggered by: Queries from different models
    # Requires: sql_statement - INSERT
    # Returns: The new record's ID
    # Last updated at: July 15, 2022
    # Owner: Adrian
    def insert_record(sql_statement)
        ActiveRecord::Base.connection.insert(
            ActiveRecord::Base.send(:sanitize_sql_array, sql_statement)
        )
    end

    # DOCU: Update records in the database
    # Triggered by: Queries from different models
    # Requires: sql_statement - UPDATE
    # Returns: The number of rows affected
    # Last updated at: July 15, 2022
    # Owner: Adrian
    def update_record(sql_statement)
        ActiveRecord::Base.connection.update(
            ActiveRecord::Base.send(:sanitize_sql_array, sql_statement)
        )
    end

    # DOCU: Delete records in the database
    # Triggered by: Queries from different models
    # Requires: sql_statement - DELETE
    # Returns: The number of rows affected
    # Last updated at: September 25, 2022
    # Owner: Adrian
    def delete_record(sql_statement)
        ActiveRecord::Base.connection.delete(
            ActiveRecord::Base.send(:sanitize_sql_array, sql_statement)
        )
    end
end