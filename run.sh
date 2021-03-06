#!/bin/bash
JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home"
CLASS_PATH="/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/charsets.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/deploy.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/cldrdata.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/dnsns.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/jaccess.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/jfxrt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/localedata.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/nashorn.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/sunec.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/sunjce_provider.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/sunpkcs11.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/ext/zipfs.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/javaws.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/jce.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/jfr.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/jfxswt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/jsse.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/management-agent.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/plugin.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/resources.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/jre/lib/rt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/ant-javafx.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/dt.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/javafx-mx.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/jconsole.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/packager.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/sa-jdi.jar:/Library/Java/JavaVirtualMachines/jdk1.8.0_73.jdk/Contents/Home/lib/tools.jar:/Users/henri.vandenbulk/projects/cloudsim/modules/cloudsim-examples/target/classes:/Users/henri.vandenbulk/projects/cloudsim/modules/cloudsim/target/classes:/Users/henri.vandenbulk/.m2/repository/com/opencsv/opencsv/3.7/opencsv-3.7.jar:/Users/henri.vandenbulk/.m2/repository/org/apache/commons/commons-lang3/3.3.2/commons-lang3-3.3.2.jar:/Users/henri.vandenbulk/.m2/repository/org/apache/commons/commons-math3/3.3/commons-math3-3.3.jar:/Users/henri.vandenbulk/.m2/repository/commons-cli/commons-cli/1.4/commons-cli-1.4.jar"

# Variables
HOSTS="2 5 10"
CLOUDLETS="10 20 50 100 500 1000 2500 5000"
POLICY="MostFull FirstFit LeastFull Simple RandomSelection Balanced LeastRequested Auction"

#
# What's the max allocation of containers to VMs? 25->2
#
CSVCAT_HOME="~/tools"
RESULTS_HOME="/Users/henri.vandenbulk/projects/cloudsim/Results"
CURRENT_RUN=`date +%s`

for host in $HOSTS
do
  for vms in {5..20}
  do
    # echo $vms
    for cloudlet in $CLOUDLETS
    do
      for cap in $POLICY
      do
        echo "hosts: " $host " VMs: " $vms " cloudlets: " $cloudlet " policy: " $cap
        $JAVA_HOME/bin/java -classpath $CLASS_PATH org.cloudbus.cloudsim.examples.container.ContainerOverbooking --hosts $host --cloudlets $cloudlet --cap $cap --vms $vms -i 100 -r 1
      done
    done
  done
done

# Combine all the results together
$CSVCAT_HOME/csvcat --skip-headers $RESULTS_HOME/stats/*.csv > $RESULTS_HOME/$CURRENT_RUN.csv
