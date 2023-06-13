#!/usr/bin/perl

######
#
# Modified at 2023-06-12 16:24:00 KST ~ 2023-06-12 17:55:55 KST
# by Cellularhacker (wva3cdae@gmail.com)
# Github @Cellularhacker
#
# Check Updates at : https://github.com/Cellularhacker/linux-tools/blob/main/openpbs/execute-pbsnodes_status.pl
#
######

use strict;
use warnings;

my %node_states = ();
my $id = "";
my $seq = "";
my $status = "";
my $memory = "";
my $threads = "";

#my $file = <>; # 로그 파일의 경로를 입력하세요.

#print "-->    $file <--- \n";

#open my $info, $file or die "Could not open $file: $!";

#while (my $line = <$info>) {
while (my $line = <>) {
  chomp $line;

  if ($line =~ /^ {5}(state)/) {
    my ($trash, $dummy, $dummy2, $state) = $line =~ /(.*)(state)(\ \=\ )(.*)/;
    #push @{$cds{$start}}, $gene, $end, $dir;

    $status = $state;
  } elsif ($line =~ /^ {5}(pcpus)/) {
    my ($t_1, $t_2, $t_3, $pcpus) = $line =~ /(.*)(pcpus)(\ \=\ )(.*)/;

    $threads = $pcpus;
  } elsif ($line =~ /^ {5}(resources_available\.mem)/) {
    my ($t_1, $t_2, $t_3, $mem_kb) = $line =~ /(.*)(resources_available\.mem)(\ \=\ )(.*)kb/;
    my $mem_mb = $mem_kb / 1024;
    my $mem_gb = $mem_mb / 1024;
    #print "Mem GB is -> $mem_gb\n";

    $memory = $mem_gb;
  } elsif ($line =~ /^node(\d+)$/) {
    $id = "";
    $status = "";
    $threads = -1;
    $memory = "";

    $id = $line;
  } elsif ($line =~ /^$/) {
    #print "id: $id, status: $status\n";
    push @{$node_states{$id}}, $status, $threads, $memory;

    $id = "";
    $status = "";
    $threads = -1;
    $memory = "";
  }
}

foreach my $node (sort keys %node_states) {
  my ($s, $t, $m) = @{$node_states{$node}};
  my $status_str = sprintf("%s%s",$s," " x (8 - length($s)));
  my $thread_str = sprintf("%d Threads", $t);
  my $mem_int_str = sprintf("%d", (int($m)));
  my $mem_padding = " " x (4 - length($mem_int_str));
  my $mem_str = sprintf("%s%.2f GB of RAM",$mem_padding,$m);
  print join "\t", $node, $status_str, $thread_str, $mem_str;
  print "\n";
}

#close $info;
