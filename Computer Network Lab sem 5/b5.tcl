set ns [new Simulator]
set nf [open b5.nam w]
$ns namtrace-all $nf
set nd [open b5.tr w]
$ns trace-all $nd

proc finish { } {
    global ns nf nd
    $ns flush-trace
    close $nf
    close $nd
    exec nam b5.nam &
    exit 0
}
for {set i 0} {$i < 7} {incr i} {
        set n($i) [$ns node]
}
$ns duplex-link $n(0) $n(2) 1Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 1Mb 10ms DropTail
$ns simplex-link $n(2) $n(3) 0.3Mb 100ms DropTail
$ns simplex-link $n(3) $n(2) 0.3Mb 100ms DropTail

set lan [$ns newLan "$n(3) $n(4) $n(5) $n(6)" 0.5Mb 40ms LL Queue/DropTail MAC/Csma/Cd Channel]

$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns simplex-link-op $n(2) $n(3) orient right
$ns simplex-link-op $n(3) $n(2) orient left

set tcp0 [new Agent/TCP/Newreno]
$ns attach-agent $n(0) $tcp0
$tcp0 set fid_ 1
$tcp0 set packetSize_ 552
set sink0 [new Agent/TCPSink/DelAck]
$ns attach-agent $n(4) $sink0
$ns connect $tcp0 $sink0
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set udp0 [new Agent/UDP]
$ns attach-agent $n(1) $udp0
$udp0 set fid_ 2
set null0 [new Agent/Null]
$ns attach-agent $n(6) $null0
$ns connect $udp0 $null0
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0
$cbr0 set type_  CBR
$cbr0 set packetSize_ 1000
$cbr0 set rate_ 0.05Mb
$cbr0 set random_ false

$ns at 0.0 "$n(0) label TCP_Traffic"
$ns at 0.0 "$n(1) label UDP_Traffic"
$ns at 0.3 "$cbr0 start"
$ns at 0.8 "$ftp0 start"
$ns at 7.0 "$ftp0 stop"
$ns at 7.5 "$cbr0 stop"
$ns at 8.0 "finish"
$ns run
