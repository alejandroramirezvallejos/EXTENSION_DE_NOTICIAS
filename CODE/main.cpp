#include <iostream>
#include <fstream>
#include <cctype>
#include <sstream>
#include <locale>
#include <codecvt>
#include <algorithm>
using namespace std;

void database_in (string database);
void database_out (long long int letters, long long int words, long long int sentences, long long int paragraphs, string text);
string news_source(string text);
bool date_identifier(const string & text, long long int index);
bool blank(void);
long long int count_paragraphs(const string & text, bool &prev_paragraph);

int main() {
    locale::global(locale(locale(), new codecvt_utf8<wchar_t>));
    string location = "../DATABASE/";
    cout<<"Enter the year of the database to analyze (2010-2023)"<<endl;
    int year = 0;
    cin>>year;
    if (year > 2023 || year < 2010) {
        cout<<"Invalid date entered"<<endl;
    }
    else {
        cout<<"Are you sure? type 1 to confirm"<<endl;
        bool pass = false;
        cin>>pass;
        if (pass == true) {
            database_in(location + to_string(year) + ".txt");
        }
    }
    return 0;
}

void database_in(string database) {
    ifstream db;
    string text, url;
    int pass = 0;
    long long int letters = 0;
    long long int words = 0;
    long long int sentences = 0;
    long long int paragraphs = 0;
    static bool first_line = false;
    bool identifier = false;
    bool prev_paragraph = false;
    db.open(database, ios::in);
    if (db.fail()) {
        cout<<"Error opening the file"<<endl;
        return;
    }
    while (!db.eof()) {
        getline(db, text);
        if (first_line == false) {
            database_out(0, 0, 0, 0, text);
            first_line = true;
            continue;
        }
        if (identifier == false && text != "####") {
            url = text;
        }
        if (text == "####") {
            if (identifier == true) {
                identifier = false;
                pass++;
            }
            else {
                identifier = true;
                pass++;
                continue;
            }
        }
        if (identifier == true) {
            stringstream tx(text);
            string word;
            for (long long int i = 0; i < text.size(); i++) {
                if (isalnum(text[i])) {
                    letters++;
                    prev_paragraph = true;
                }
                if (text[i] == '.' && date_identifier(text, i) == false) {
                    sentences++;
                }
            }
            while (tx>>word) {
                words++;
            }
            paragraphs += count_paragraphs(text, prev_paragraph);
        }
        if (pass == 2) {
            if (prev_paragraph == true) {
                paragraphs++;
            }
            database_out(letters, words, sentences, paragraphs, url);
            pass = 0;
            letters = 0;
            words = 0;
            sentences = 0;
            paragraphs = 0;
            prev_paragraph = false;
        }
    }
}

void database_out(long long int letters, long long int words, long long int sentences, long long int paragraphs, string text) {
    ofstream db;
    static bool start = true;
    static string year;
    static bool empty = true;
    db.open("../DATA/data.csv", ios::app);
    if (db.fail()) {
        cout<<"An unexpected error occurred!"<<endl;
        cout<<"Delete the data.txt file and run the program again"<<endl;
    }
    if (empty == true) {
        if (blank() == true) {
            db<<"Year,Source,URL,Letters,Words,Sentences,Paragraphs"<<endl;
            empty = false;
        }
        else {
            empty = false;
        }
    }
    if (start == true) {
        year = text;
        start = false;
    }
    else if (start == false) {
        db<<year<<","<<news_source(text)<<","<<text<<","<<letters<<","<<words<<","<<sentences<<","<<paragraphs<<endl;
    }
}

string news_source(string text) {
    string result;
    for (long long int i = 0; i < text.size(); i++) {
        if (text[i] == '/' && text[i + 1] != '/') {
            if (text[i + 1] == 'w') {
                i = i + 5;
                while (text[i] != '.') {
                    result += text[i];
                    i++;
                }
                break;
            }
            else {
                i++;
                while (text[i] != '.') {
                    result += text[i];
                    i++;
                }
                break;
            }
        }
    }
    return result;
}

bool date_identifier(const string & text, long long int index) {
    if (index > 0 && index < text.size() - 1) {
        return isdigit(text[index - 1]) && text[index] == '.' && isdigit(text[index + 1]);
    }
    return false;
}

bool blank(void) {
    ifstream file("data.csv");
    return file.peek() == ifstream::traits_type::eof();
}

long long int count_paragraphs(const string & text, bool & prev_paragraph) {
    long long int paragraphs = 0;
    string line = text;
    line.erase(remove_if(line.begin(), line.end(), ::isspace), line.end());
    if (line.empty() == true && prev_paragraph == true) {
        paragraphs++;
        prev_paragraph = false;
    }
    return paragraphs;
}