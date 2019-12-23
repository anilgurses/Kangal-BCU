#include "db.h"

//  SQlite browser yazılımı ile db ye müdahale edebilirsiniz.

db::db()
{

}


void db::initDb(){
    pwd = QDir::currentPath();
    mydb.setDatabaseName(pwd);

    if(mydb.open()) {
       //Açıldıysa
    }

}


// Usernameleri sql database den çekme

void db::getUsernames(QString *usernames[]){
    QSqlQuery query(mydb);
    QSqlQueryModel *model = new QSqlQueryModel();
    QString sql = "SELECT *FROM USERNAMES";

    query.exec(sql);


}
