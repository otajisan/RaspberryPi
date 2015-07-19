#!/user/local/bin/perl

use strict;
use warnings;
use utf8;
use Time::HiRes 'sleep';
use Math::Round;

#
# メイン処理
#
sub main
{
    # Lチカに利用するPIN番号が引数に指定されていない
    if (@ARGV == 0) {
        print "invalid argument. please assign gpio num.(ex. 18)";
        return 1;
    }

    my $gpio = $ARGV[0];

    # PIN設定
    exec_cmd("echo $gpio > /sys/class/gpio/export");
    exec_cmd("echo out > /sys/class/gpio/gpio$gpio/direction");

    # Lチカ
    my $LIMIT = 10;
    for (my $count = 0; $count < $LIMIT; $count++){
        print ">>>> [count = $count]\n";
        # 点灯
        turn_on_LED($gpio);
        sleep(getRandomeTime());
        # 消灯
        turn_off_LED($gpio);
        sleep(getRandomeTime());
    }

    return 0;
}

#
# 点灯(消灯)時間をランダムに返す
#
sub getRandomeTime
{
    return nearest(0.1, rand(1));
}

#
# LED制御
#
sub turn_on_LED  { ctrl_LED(1, shift); }
sub turn_off_LED { ctrl_LED(0, shift); }
sub ctrl_LED
{
    my ($val, $gpio) = @_;
    exec_cmd("echo $val > /sys/class/gpio/gpio$gpio/value");
}

#
# コマンドを実行する
#
sub exec_cmd
{
    my ($cmd) = shift;
    print "$cmd\n";
    my $output = `$cmd 2>&1`;
    chomp($output);
    my $status = $? / 256;
    return ($status, $output);
}

&main();
