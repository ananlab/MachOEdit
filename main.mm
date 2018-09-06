//
//  main.m
//  Mach-O Browser
//
//  Created by psaghelyi on 10/06/2010.
//


// every std IO operation needs to be paused until pipes are in use
#include "main.h"

NSCondition * pipeCondition;
int32_t numIOThread;



int 
main(int argc, const char *argv[])
{
  pipeCondition = [[NSCondition alloc]init];
  numIOThread = 0;
  return NSApplicationMain(argc, argv);
}


void emptyBin( const char *binPath)
{
    FILE *fpSr = fopen(binPath, "wb");
    fclose(fpSr);
}

void copyBin( const char *binPath)
{
    printf("binPath==%s\n",binPath);
    char renameBinPath[1024];
    strcpy(renameBinPath,binPath);
    strcat(renameBinPath,"_RE");
    
    int c;
    FILE *fpSrc, *fpDest;
    fpSrc = fopen(binPath, "rb");
    if(fpSrc==NULL)
    {
        printf( "Source file open failure.");
        return ;
    }
    
    fpDest = fopen(renameBinPath, "wb");
    if(fpDest==NULL)
    {
        printf("Destination file open failure.");
        return ;
    }
    while((c=fgetc(fpSrc))!=EOF){
        fputc(c, fpDest);
    }
    fclose(fpSrc);
    fclose(fpDest);
}
