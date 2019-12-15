#ifndef DB_H
#define DB_H
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QtSql>
#include <vector>

class db
{

    QString pwd;
    QSqlDatabase mydb;
public:
    db();
    void initDb();
    void getUsernames(QString *usernames[]);

};

#endif // DB_H
