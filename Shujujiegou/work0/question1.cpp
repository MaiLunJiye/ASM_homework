#include <string>
#include <iostream>

using namespace std;

class StudentData 
{ 
    friend class StudentsDB;
private:
    string       Name;  // student's name
    float        grade; // student's grade
    string       ID;    // student's id
    StudentData* next;  // next student's point

public: 

    //getters
    string getName()  { return Name;  }
    string getID()    { return ID;    }
    float  getGrade() { return grade; }

    /**
     * @brief Construcor
     *
     * @param id    : student's id
     * @param name  : student's name
     * @param grade : student's grade
     */
    StudentData (string id, string name, float grade) {
        this->ID = id;
        this->Name = name;
        this->grade = grade;
        this->next = NULL;
    }


    /**
     * @brief print the student's detail
     */
    void showDetails() {
        cout << "ID: " << ID << ", name: " << Name << ", grade: " << grade << endl;
    }
}; 

class StudentsDB 
{ 
private: 
    float       avg;          // Average of all students
    int         studentNum;   // number of students
    StudentData *studentlist; // head point of students data list

public: 

    //getters
    float getAvg(){ return avg; }
    int getStudentNum(){ return studentNum; }

    /**
     * @brief output student's infomations whoes grade bigger than Paramenter
    *
     * @param bigthan : float bigthan:  limit the output
     */
    void showGradeBigThan(float bigthan = 0){
        StudentData *temp = studentlist;
        while (temp != NULL && temp->grade > bigthan) { 
            temp->showDetails();
            temp = temp->next; 
        } 
    }

    /**
     * @brief 
     *	    Insert the StudnetData
     *	    Data will sort by grade
     *
     * @param insert : Insert the StudentData point
     */
    void Insert(StudentData* insert) {
        StudentData* current = this->studentlist;
        if(current == NULL) {
            studentlist = insert;

        } else if (current->grade < insert->grade) { 
            insert->next = current;
            studentlist = insert;
        } else { 
            while (current->next != NULL && current->next->grade > insert->grade) { 
                current = current->next; 
            }  
            insert->next = current->next;
            current->next = insert;

            avg = ( avg*studentNum + insert->grade) / (studentNum + 1);
            studentNum++;
        } 
    }

    //Constructor
    StudentsDB () {
        this->avg = 0;
        this->studentNum = 0;
    }

    //must free the studentlist 
    ~StudentsDB () {
        while (studentlist != NULL) {
            StudentData *temp = studentlist;
            studentlist = studentlist->next;
            delete temp;
        }
    }
}; 


int main(int argc, char* argv[]){
    cout << "input the sum of student" <<endl;
    int  sum;
    cin  >> sum                        ;
    cout << "please input data like  'id name grade'" << endl;
    cout << "example: "                <<endl;
    cout << "123456 Mike 76"           << endl;
    cout << "==========================================" << endl;

    StudentsDB* database = new StudentsDB();

    while(sum--) {
        string id,name;
        float grade;
        cin >> id >> name >> grade;
        database->Insert( new StudentData(id, name, grade) );

    }

    database->showGradeBigThan(30);
    
    return 0;
}

/*

4
123 eee 22
333 sss 55
122 sss 11
223 ggg 33

*/
