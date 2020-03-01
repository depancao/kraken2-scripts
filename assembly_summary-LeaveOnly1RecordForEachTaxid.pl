#!/usr/bin/perl -w
my $items = `grep -v '^#' assembly_summary.txt | cut -f6 | sort | uniq`;
my @array = split("\n", $items);
my %db;
foreach my $i (@array)
        {
        $db{$i} = {'fenshu' => '100', 'neirong' => ''};
        }

open(IN, qq/grep -v '^#' assembly_summary.txt|/);
while(my $i = <IN>)
        {
        chomp($i);
        my @array = split("\t", $i);
        my $level = $array[4].$array[11];
        my $score;
        if($level eq "representative genomeComplete Genome") {$score = 1;}
        elsif($level eq "representative genomeChromosome") {$score = 2;}
        elsif($level eq "representative genomeScaffold") {$score = 3;}
        elsif($level eq "representative genomeContig") {$score = 4;}
        elsif($level eq "reference genomeComplete Genome") {$score = 5;}
        elsif($level eq "reference genomeChromosome") {$score = 6;}
        elsif($level eq "naComplete Genome") {$score = 7;}
        elsif($level eq "naChromosome") {$score = 8;}
        elsif($level eq "naScaffold") {$score = 9;}
        elsif($level eq "naContig") {$score = 10;}

        if(exists($db{$array[5]}))
                {
                if( ${$db{$array[5]}}{'fenshu'} > $score)
                        { ${$db{$array[5]}}{'fenshu'} = $score ; ${$db{$array[5]}}{'neirong'} = $i; }
                }
        }

foreach my $j (keys(%db))
        {
        print(${$db{$j}}{'neirong'});
        print("\n");
        }
