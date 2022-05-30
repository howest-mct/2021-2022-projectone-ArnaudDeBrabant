from .Database import Database


class DataRepository:
    @staticmethod
    def json_or_formdata(request):
        if request.content_type == 'application/json':
            gegevens = request.get_json()
        else:
            gegevens = request.form.to_dict()
        return gegevens

    @staticmethod
    def read_status_device():
        sql = "SELECT * from historiek"
        return Database.get_rows(sql)

    @staticmethod
    def read_score():
        sql = "SELECT * from score"
        return Database.get_one_row(sql)

    @staticmethod
    def read_rfid(RFID, naam):
        sql = "INSERT INTO gebruiker (RFID_tag, Naam) VALUES (%s, %s)"
        params = [RFID, naam]
        return Database.execute_sql(sql, params)
