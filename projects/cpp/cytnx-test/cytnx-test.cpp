#include <iostream>
#include "cytnx.hpp"
using namespace std; 
namespace cy=cytnx;
int main(){
    cout << "Hello World!" << endl; 
    auto A = cy::Tensor({2, 3});
    auto B = A;

    cout << cy::is(B, A) << endl;
    auto C = cy::ones(4); 
    cout << C << endl; 
    return 0; 
}
