# tpch-mysql
[TPC-H Benchmark toolkit](https://www.tpc.org/tpch/) with specific modification for MYSQL


## What's done
- Copied makefile.suite to makefile, and specify 
  - `CC` to `gcc`
  - `DATABASE` to `MYSQL`
  - `MATCHINE` to `LINUX`
  - `WORKLOAD` to `TPCH`
- Modify `tpcd.h` and add MYSQL-related specification  
  ```h
    #ifdef MYSQL
    #define GEN_QUERY_PLAN ""
    #define START_TRAN "START TRANSACTION"
    #define END_TRAN "COMMIT"
    #define SET_OUTPUT ""
    #define SET_ROWCOUNT "LIMIT %d;\n"
    #define SET_DBASE "USE %s;\n"
    #endif
  ```
- Add two extra files `mysql-dss.ddl` and `mysql-dss.ri`, the original `mysql-dss.ddl` and `mysql-dss.ri` are not changed
- Makefile and generate `dbgen` and `qgen`

## Quickstart

### Prerequiste
- Docker environment with at least 4G memory and 16G disk space.

### Run from docker image
- Create and start a container named "tpch-mysql".
    ```bash
    docker run \
        --name tpch-mysql \
        --rm \
        --detach \
        iamjane/tpch-mysql:latest
    ```
- Display TPC-H toolkit help message
    ```bash
    docker exec \
        tpch-mysql \
        bash -c "./dbgen -h" 
    ```
    If everything goes well, you will see the message as follows.
    ```plaintext
    TPC-H Population Generator (Version 3.0.0 build 0)
    Copyright Transaction Processing Performance Council 1994 - 2010
    USAGE:
    dbgen [-{vf}][-T {pcsoPSOL}]
            [-s <scale>][-C <procs>][-S <step>]
    dbgen [-v] [-O m] [-s <scale>] [-U <updates>]

    Basic Options
    ===========================
    -C <n> -- separate data set into <n> chunks (requires -S, default: 1)
    -f     -- force. Overwrite existing files
    -h     -- display this message
    -q     -- enable QUIET mode
    -s <n> -- set Scale Factor (SF) to  <n> (default: 1) 
    -S <n> -- build the <n>th step of the data/update set (used with -C or -U)
    -U <n> -- generate <n> update sets
    -v     -- enable VERBOSE mode

    Advanced Options
    ===========================
    -b <s> -- load distributions for <s> (default: dists.dss)
    -d <n> -- split deletes between <n> files (requires -U)
    -i <n> -- split inserts between <n> files (requires -U)
    -T c   -- generate cutomers ONLY
    -T l   -- generate nation/region ONLY
    -T L   -- generate lineitem ONLY
    -T n   -- generate nation ONLY
    -T o   -- generate orders/lineitem ONLY
    -T O   -- generate orders ONLY
    -T p   -- generate parts/partsupp ONLY
    -T P   -- generate parts ONLY
    -T r   -- generate region ONLY
    -T s   -- generate suppliers ONLY
    -T S   -- generate partsupp ONLY

    To generate the SF=1 (1GB), validation database population, use:
            dbgen -vf -s 1

    To generate updates for a SF=1 (1GB), use:
            dbgen -v -U 1 -s 1
    ```

- Generate only `nation.tbl` with verbose, and preview first five rows
    ```bash
        docker exec \
            tpch-mysql \
            bash -c "./dbgen -T n -v && head -n 5 nation.tbl" 
    ```
    You can check the generated result with verbose message as follows.
    ```plaintext
    TPC-H Population Generator (Version 3.0.0)
    Copyright Transaction Processing Performance Council 1994 - 2010
    Generating data for nation table/
    Preloading text ... 100%
    done.
    0|ALGERIA|0| haggle. carefully final deposits detect slyly agai|
    1|ARGENTINA|1|al foxes promise slyly according to the regular accounts. bold requests alon|
    2|BRAZIL|1|y alongside of the pending deposits. carefully special packages are about the ironic forges. slyly special |
    3|CANADA|1|eas hang ironic, silent packages. slyly regular packages are furiously over the tithes. fluffily bold|
    4|EGYPT|4|y above the carefully unusual theodolites. final dugouts are quickly across the furiously regular d|
    ```
- Stop and remove container  
   ```bash
    docker stop tpch-mysql
    ```  


### Build image from Dockerfile
- `git clone git@github.com:LadyForest/tpch-mysql.git && cd tpch-mysql`
- `docker image build -t {image} .`

### Run directly without Docker
- `git clone git@github.com:LadyForest/tpch-mysql.git && cd tpch-mysql/TPC-H\ V3.0.1/dbgen/`
- `./dbgen -h`
