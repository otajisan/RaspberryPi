#!/user/local/bin/perl

use strict;
use warnings;
use utf8;

#
# メイン処理
#
sub main
{
    # Lチカに利用するPIN番号が引数に指定されていない
    if (@ARGV == 0) {
        print "invalid argument. please assign pin.(ex. 18)";
        return 1;
    }

    my $pin = $ARGV[0];

    # PIN設定
    exec_cmd("echo $pin > /sys/class/gpio/export");
    exec_cmd("echo out > /sys/class/gpio/gpio$pin/direction");

    # Lチカ
    my $LIMIT = 10;
    for (my $count = 0; $count < $LIMIT; $count++){
        print ">>>> [time = $count]\n";
        turn_on_LED($pin);
        sleep(1);
        turn_off_LED($pin);
        sleep(1);
    }

    return 0;
}

#
# LED制御
#
sub turn_on_LED  { ctrl_LED(1, shift); }
sub turn_off_LED { ctrl_LED(0, shift); }
sub ctrl_LED
{
    my ($val, $pin) = @_;
    exec_cmd("echo $val > /sys/class/gpio/gpio$pin/value");
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
