#include <iostream>
#include "cytnx.hpp"
using namespace std; 
namespace cy=cytnx;
int main(){
    cout << "Hello World!" << endl; 
    auto A = cytnx::Tensor({2, 3});
    auto B = A;

    cout << cytnx::is(B, A) << endl;
    return 0; 
}
