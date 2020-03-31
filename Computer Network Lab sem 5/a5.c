#include<stdio.h>
#define N len(g)
int len(char s[])
{
    int i,a,length=0;
    for(i=0;s[i]!='\0';i++)
    {
        length++;
    }
    a=length;
    return a;
}
char t[28],cs[28],g[16];
int a,i,c;
void xor()
{
    for(c=1;c<N;c++)
    {
        cs[c]=((cs[c]==g[c])?'0':'1');
    }
}
void crc()
{
    for(i=0;i<N;i++)
      cs[i]=t[i];
    do{
        if(cs[0]=='1')
         xor();
        for(c=0;c<N-1;c++)
          cs[c]=cs[c+1];
        cs[c]=t[i++];
    }while(i<=a+N-1);
}
int main()
{
    printf("Enter the dataword:\n");
    scanf("%s",t);
    printf("Enter the divisor:\n");
    scanf("%s",g);
    a=len(t);
    for(i=a;i<a+N-1;i++)
      t[i]='0';
    printf("Modified data is:%s\n",t);
    crc();
    printf("Checksum is:%s\n",cs);
    for(i=a;i<a+N-1;i++)
      t[i]=cs[i-a];
    printf("Final codeword is :%s\n",t);
    printf("Test error detection 0(yes) 1(no) ?: ");
    scanf("%d",&i);
    if(i==0)
    {
        do{
            printf("Enter the position at which error is inserted\n");
            scanf("%d",&i);
        }while(i==0||i>a+N-1);
        t[i-1]=(t[i-1]=='0')?'1':'0';
        printf("Erroneous data is :%s\n",t);
        if(t[c-1]=='0')
         t[c-1]='1';
        else if(t[c-1]=='1')
         t[c-1]='0';
    }
    printf("Recieved dataword is:%s\n",t);
    crc();
    for(i=0;(i<N-1)&&(cs[i]!='1');i++)
    ;
        if(i<N-1)
         printf("Error detected,Syndrome bits are:%s\n",cs);
        
        else
        {
            printf("No error detected syndrome bit are:%s\n",cs);
        }
    return 0;
}