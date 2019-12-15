#include "db.h"

//  SQlite browser yazılımı ile db ye müdahale edebilirsiniz.

db::db()
{

}


void db::initDb(){
    pwd = QDir::currentPath();
    mydb.setDatabaseName(pwd);

    if(mydb.open()) {
        QString sql = "SELECT *FROM TELEFON";

    }

}


// Usernameleri sql database den çekme

void db::getUsernames(QString *usernames[]){

}
