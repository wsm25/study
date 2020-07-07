#include <stdio.h>
#include <malloc.h>
#define N 30
#define LOOP 3

struct chain{
	int num;
	chain* p;
}

chain* initch(){
	chain* ph=(chain *)malloc(sizeof(chain));
	chain* pb=ph;
	int i=1;
	do{
		pb->num=i;
		pb->p=(chain *)malloc(sizeof(chain));
		pb=pb->p;
	}while((++i)<=N-1);
	pb->p=ph;
	return ph;
}

int main(){
	chain* ph=initch();
	chain* pi=NULL;
	int i=0;
	while(ph!=(ph->p)){
		if(++i>=LOOP){
			i=0;
			ph->p=(ph->p)->p;
		}
	}
	printf("%d\n",ph->num);
	return 0;
}
