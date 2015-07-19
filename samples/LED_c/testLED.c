/* testLED.c */
#include <stdio.h>
#include <errno.h>
#include <string.h>

#include <wiringPi.h>
#include <stdio.h>

#define WRITE_PIN 1

int main(void)
{
    if(wiringPiSetup() == -1){
        printf("error wiringPi setup\n");
        return 1;
    }
    pinMode(WRITE_PIN, OUTPUT);

    int i;
    for (i = 0 ; i < 8 ; ++i) {
        printf ("%3d\n", i) ;
        digitalWrite(WRITE_PIN, 0);  //LED off
        delay(1000);    //wait 1000ms

        digitalWrite(WRITE_PIN, 1);  //LED on
        delay(1000);    //wait 1000ms
    }
    return 0;
}
