#Sample nodes.pp for 14 node cluster
node 'filebeat_1'       {
        include filebeat
}
node 'filebeat_2'       {
        include filebeat
}
node 'filebeat_3'       {
        include filebeat
}
node 'haproxy'          {
        include haproxy
}
node 'redis1'           {
        include redis::install_master
}
node 'redis2'           {
        include redis::install_slave
}
node 'redis3'           {
        include redis::install_slave
}
node 'logstash1'           {
        include logstash
}
node 'logstash2'           {
        include logstash
}
node 'logstash3'           {
        include logstash
}

node 'elasticsearch1'      {
        include elasticsearch
}
node 'elasticsearch2'      {
        include elasticsearch
}
node 'elasticsearch3'      {
        include elasticsearch
}
node 'dashboard'      {
        include kibana
        include nginx
}
