/**
 * trooper.c:
 * [Compile and Execute]
 * $ gcc -o trooper trooper.c -lwiringPi -lpthread && sudo ./trooper
 */
#include <stdio.h>
#include <errno.h>
#include <string.h>

#include <wiringPi.h>
#include <softTone.h>

#define PIN 1 // GPIO 18
#define TEMPO 1500

/**
 * 音階の配列
 */
int interval[19] =
{
    /* low */
    262, // 0:C
    294, // 1:D
    330, // 2:E
    349, // 3:F
    392, // 4:G
    440, // 5:A
    494, // 6:B
    /* high */
    523, // 7:C
    587, // 8:D
    659, // 9:E
    698, // 10:F
    784, // 11:G
    880, // 12:A 
    988  // 13:B
};

/**
 * 音を奏でる
 */
void play(int scale, int time)
{
  softToneWrite(PIN, interval[scale]);

  delay((TEMPO / time) - 20);
  softToneWrite(PIN, 0);
  delay(20);
}

/**
 * 音階の確認用
 */
int check_scale()
{
    play(0, 4); // C
    play(1, 4);
    play(2, 4);
    play(3, 4);
    play(4, 4);
    play(5, 4);
    play(6, 4);
    play(7, 4); // C
}

/**
 * Trooperを演奏する
 */
int play_Trooper()
{
    printf("####### To Too Trooper #######\n");
    // トゥートゥートゥルトゥー1
    play(9, 8); // E
    play(9, 8);
    play(9, 16);
    play(8, 16);
    play(6, 8);
    // トゥートゥートゥルトゥー2
    play(8, 8); // D
    play(8, 8);
    play(8, 16);
    play(7, 16);
    play(5, 8);
    // トゥートゥートゥルトゥー3
    play(7, 8); // C
    play(7, 8);
    play(7, 16);
    play(6, 16);
    play(4, 8);
    // トゥルルルー
    play(8, 8); // D
    play(11, 8);
    play(8, 8);
    play(9, 4);
}

/**
 * 実処理
 */
int main ()
{
    wiringPiSetup();
    softToneCreate(PIN) ;

    // 音階のテスト用
    //check_scale();

    // Trooperを演奏する
    play_Trooper();

    return 0;
}
