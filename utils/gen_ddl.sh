#!/bin/bash


username="rfph_app_01"
dbname="rfph"
host="172.25.1.147"
port="5432"

export PGPASSWORD='gdip2'


# List of table names
table_names=("rfph.t_edcc001_l03" "rfph.t_edcc001_m01" "rfph.t_edcc003_l04" "rfph.t_edcc002_l03" "rfph.t_edcc004_l05" "rfph.t_edcc005_l01" "rfph.t_cmnb002_p91" "rfph.t_edcc002_m01" "rfph.t_lgog003_l01" "rfph.t_edcc004_l04" "rfph.t_lgoe003_l01_his" "rfph.t_edcc001_l05" "rfph.t_edcc003_l02" "rfph.t_edcc002_l02" "rfph.t_edcc001_d07" "rfph.t_cmnb002_p92" "rfph.t_cmnb002_m91" "rfph.t_ytha001_m01" "rfph.t_edcc001_l08" "rfph.t_edcc003_m01" "rfph.t_dwnld_h01" "rfph.t_edcc003_l03" "rfph.t_edcc001_d09" "rfph.t_edcc004_l01" "rfph.t_rgud005_l02" "rfph.t_lgog001_l01" "rfph.t_edcc004_l03" "rfph.t_lgog003_m01" "rfph.t_edcc001_l02" "rfph.t_rgud001_l05" "rfph.t_rgud005_l01" "rfph.t_lgog001_m01" "rfph.t_dscsn_sys_dept_m01" "rfph.t_edcc004_l02" "rfph.t_edcc001_d04" "rfph.t_lgog002_m01" "rfph.t_edcc004_d06" "rfph.t_edcc001_l06"
)


# Function to generate DDL for a table
generate_ddl() {
    local table_name=$1
    local output_file="$table_name.sql"

    # Generate DDL using pg_dump
    pg_dump -U $username -d $dbname -h $host -p $port -s -t $table_name > stage_sql/$output_file

    echo "DDL for table $table_name has been saved to $output_file"
}

# Loop through table names and generate DDL
for table_name in "${table_names[@]}"
do
    generate_ddl "$table_name"
done


