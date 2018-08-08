 <!DOCTYPE html>
 <html>
      <head>
           <title>KACL - ELBs</title>
           <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
           <script type="text/javascript" src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
           <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
           <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
           <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/r/bs-3.3.5/jq-2.1.4,dt-1.10.8/datatables.min.css"/>
           <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.15/b-1.4.0/b-html5-1.4.0/datatables.min.js"></script>
           <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
           <link rel="stylesheet" href="https://cdn.datatables.net/buttons/1.4.0/css/buttons.dataTables.min.css"/>
           <style>
                table, th {
                          word-break:keep-all;
                          }
                table, td {
                          word-break:break-all;
                          }
                ul {
                    list-style-type: none;
                    margin: 0;
                    padding: 0;
                    overflow: hidden;
                    background-color: #333;
                }
                li {
                    float: left;
                }
                li a {
                    display: inline-block;
                    color: white;
                    text-align: center;
                    padding: 14px 16px;
                    text-decoration: none;
                }
                li a:hover {
                    background-color: #111;
                }
           </style>
      </head>
      <body>
      <ul>
        <li><a href="index.php">INSTANCEs</a></li>
        <li><a href="fqdn.php">FQDNs</a></li>
        <li><a href="elb.php">ELBs</a></li>
        <li><a href="eni.php">ENIs</a></li>
      </ul>
           <br /><br />
           <h2 align="center">AWS ELB List</a></h3>
           <div class="container">
                <table id="data-table" class="table table-bordered">
                     <thead>
                          <tr>
                               <th>Domain</th>
                               <th>ELB</th>
                               <th>Instance</th>
                          </tr>
                     </thead>
                </table>
           </div>
           <h6 align="center">Last updated @ <?php  echo exec("ls -l --time-style='+%d-%m-%Y %H:%M %Z' elb.json| awk '{print $6,$7,$8}'");   ?> </a></h3>
      </body>
 </html>

 <script>
$(document).ready(function() {
    $('#data-table').DataTable( {
        "processing": true,
        "ajax": "elb.json",
        "columns": [
            { "data": "0" },
            { "data": "1" },
            { "data": "2" },
        ],
        dom: 'lBfrtip',
        buttons: [
            { extend: 'copyHtml5', text: 'Copy to clipboard' },
            { extend: 'excelHtml5', text: 'Download to Excel' }
        ]
    } );
    $('div.dataTables_filter input').focus();
} );
 </script>
