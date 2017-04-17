#include <string>
#include <iostream>

using namespace std;

class StudentData 
{ 
public: 
    string Name;
    float grade;
    string ID;

    StudentData (string ID, string Name, float grade) {
        this->ID   = ID;
        this->Name = Name;
        this->grade = grade;
    }

    void showDetails() {
        cout << "ID: " << ID << ", name: " << Name << ", grade: " << grade << endl;
    }
}; 

int main(int argc, char* argv[]){
    cout << "input the sum of student" <<endl;
    int sum;
    cin >> sum ;
    cout << "please input data like  'id name grade'"<<endl;
    cout << "example: " <<endl;
    cout << "123456 Mike 76" << endl;
    cout << "=========================================="<<endl;

    StudentData *data[sum];

    int index = sum;

    while(index--) {
        string id, name;
        float  grade;

        cin >> id >> name >> grade;
        data[index] = new StudentData(id, name, grade);
    }

    for (int i = 0; i < sum - 1; i++){
        int index = i;
        int j = i + 1;
        for(; j<sum; j++) {
            if( data[j]->grade > data[index]->grade ) index = j;
        }
        
        if(index != i) {
            StudentData *temp = data[i];
            data[i] = data[index];
            data[index] = temp;
        }
    }

    for (int i = 0; i < sum; i++){
        data[i]->showDetails();
    }

    for (int i = 0; i < sum; i++){
        delete data[i];
    }
    
    return 0;
}
