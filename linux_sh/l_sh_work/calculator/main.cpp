#include <mywindow.h>
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    Widget w;
    w.showMaximized();
    w.setFixedSize(250,300);
    #ifdef Q_OS_LINUX
        // Linux Desktop Centr
        w.setGeometry(QStyle::alignedRect(Qt::LeftToRight,Qt::AlignCenter,w.size(),a.screenAt(w.pos())->availableGeometry()));
    #else
        // Windows Desktop Centr
        QRect screenGeometry = QApplication::desktop()->screenGeometry();
        int x = (int)((screenGeometry.width() - w.width()) / 2);
        int y = (int)((screenGeometry.height() - w.height()) / 2);
        w.move(x,y);
    #endif
    w.setWindowIcon(QIcon(":img/logo.png"));
    w.show();

    return a.exec();
}
