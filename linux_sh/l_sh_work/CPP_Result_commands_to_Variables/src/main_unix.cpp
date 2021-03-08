#include <iostream>
#include <sstream>
#include <cstdlib>
#include <cstdio>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
	cout << "Start programs" << endl;
		
	string programs = "./dirconvert-linux-x86_64";
	
	string parameter = "../";

	if (argc > 1)
	{
		if (argc > 2)
		{
			programs = argv[1];
			parameter = argv[2];
		} else if (argc > 1)
		{
			parameter = argv[1];
		}
	} else
	{
		cout << "Not arguments" << endl;
	}
	
	string commands = programs + " " + parameter;
	
	cout<< commands << endl;
		
	const char* dat = commands.c_str();
		
	//char results = system(dat);
	//string outcommands(1,results);
	//cout<<outcommands<<endl;
    
    string bf;
    ostringstream str_buf(bf);
    streambuf *x = cout.rdbuf(str_buf.rdbuf()); // Redirection STDOUT
    string outcommands;
    system(dat);
    outcommands = str_buf.str();		// write string redirection STDOUT to variable
    cout.rdbuf(x);                       // Return redirection STDOUT on "cout"
    
    // removing all line breaks
    const string find = "\r\n";
	const string repl = "";
	size_t pos = 0;
	for (;;)
	{
		pos = outcommands.find(find, pos);
		if (pos == string::npos)
			break;

		outcommands.replace(pos, find.size(), repl);
		pos += repl.size();
	}
    
    cout << outcommands;        // Viewing the received string
    cout << "End programs" << endl;
    
    //cin.get();
    
    return 0;
}
