#include <QProcess>
#include <QString>
#include <QStringList>
#include <iostream>
#include <cstdio>
#include <cstdlib>

using namespace std;

QString readForData(QString progs, QString param) {
    QProcess process;
    process.start( progs, QStringList() << param );
    process.waitForFinished();
    return process.readAllStandardOutput();
}

int main(int argc, char* argv[]) {

	cout << "Hello World !" << endl;
	
    QString prog = "./dirconvert-linux-x86_64";
	
    QString commands = "../../";

    QString results;

    results = readForData(prog, commands);

    cout<< results.toStdString()<<endl;

	return 0;
}
