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
	
    QString prog = "dirconvert-win-x64.exe";
	
    QString commands = "../";
	
	int namelen;
	
	if (argc > 1)
	{
		if (argc > 2)
		{
			namelen = strlen(argv[1]);
			prog = QString::fromUtf8((const char *)argv[1],namelen);
			namelen = strlen(argv[2]);
			commands = QString::fromUtf8((const char *)argv[2],namelen);
		} else if (argc > 1)
		{
			namelen = strlen(argv[1]);
			commands = QString::fromUtf8((const char *)argv[1],namelen);
		}
	} else
	{
		cout << "Not arguments" << endl;
		commands = "../";
		prog = "dirconvert-win-x64.exe";
	}
	
    QString results;

    results = readForData(prog, commands);

    cout<< results.toStdString()<<endl;

	return 0;
}
