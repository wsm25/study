#include <stdio.h>
#include <malloc.h>
#define N 200
#define LOOP 3

struct chain{
	int num;
	struct chain* p;
};

struct chain* initch(){
	struct chain* ph=(struct chain *)malloc(sizeof(struct chain));
	struct chain* pb=ph;
	int i=1;
	do{
		pb->num=i;
		pb->p=(struct chain *)malloc(sizeof(struct chain));
		pb=pb->p;
	}while((++i)<=N-1);
	pb->p=ph;
	return ph;
}

int main(){
	struct chain* ph=initch();
	int i=0;
	while(ph!=(ph->p)){
		if(++i>=LOOP){
			i=0;
			ph->p=(ph->p)->p;
			ph=ph->p;
		}
	}
	printf("%d\n",ph->num);
	return 0;
}
