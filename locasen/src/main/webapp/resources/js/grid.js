
// prepare the data
//var data = new Array();
var data = [
	{ name: 'no', type: 'number', key: true},
	{ name: 'firstname', type: 'string'},
	{ name: 'lastname', type: 'string'},
    { name: 'productname', type: 'string'},
    { name: 'quantity', type: 'string'},
    { name: 'price', type: 'string'},
    { name: 'check', type: 'bool',selectionmode : 'multiplecellsextended'},
    { name: 'btn_add', type: 'button'},
    { name: 'btn_del', type: 'button'}
    
];


var firstNames =
[
    "Andrew", "Nancy", "Shelley", "Regina", "Yoshi", "Antoni", "Mayumi", "Ian", "Peter", "Lars", "Petra", "Martin", "Sven", "Elio", "Beate", "Cheryl", "Michael", "Guylene"
];
var lastNames =
[
    "Fuller", "Davolio", "Burke", "Murphy", "Nagase", "Saavedra", "Ohno", "Devling", "Wilson", "Peterson", "Winkler", "Bein", "Petersen", "Rossi", "Vileid", "Saylor", "Bjorn", "Nodier"
];
var productNames =
[
    "Black Tea", "Green Tea", "Caffe Espresso", "Doubleshot Espresso", "Caffe Latte", "White Chocolate Mocha", "Cramel Latte", "Caffe Americano", "Cappuccino", "Espresso Truffle", "Espresso con Panna", "Peppermint Mocha Twist"
];
var priceValues =
[
    "2.25", "1.5", "3.0", "3.3", "4.5", "3.6", "3.8", "2.5", "5.0", "1.75", "3.25", "4.0"
];
var btn_add = 
[
	"+"
];
var btn_del =
[
	"-"
];
for (var i = 0; i < 100; i++) {
    var row = {};
    var productindex = Math.floor(Math.random() * productNames.length);
    var price = parseFloat(priceValues[productindex]);
    var quantity = 1 + Math.round(Math.random() * 10);
    
    row["no"] = i;
    row["firstname"] = firstNames[Math.floor(Math.random() * firstNames.length)];
    row["lastname"] = lastNames[Math.floor(Math.random() * lastNames.length)];
    row["productname"] = productNames[productindex];
    row["price"] = price;
    row["quantity"] = quantity;
    row["total"] = price * quantity;
    row["btn_add"] = btn_add[0];
    row["btn_del"] = btn_del[0];
    data[i] = row;
}

var source =
{
    localdata: data,
    datatype: "json",
	
    sortcolumn : 'no',
    sortdirection : 'asc',
	
    pager: function (pagenum, pagesize, oldpagenum) {
        // callback called when a page or page size is changed.
        //pagesize: '3'
    }   
};


/* 페이징 */
var pagerrenderer = function () {
    var element = $("<div style='margin-top: 5px; width: 100%; height: 100%;'></div>");
    var paginginfo = $("#jqxgrid").jqxGrid('getpaginginformation');
    
    for (i = 1; i < paginginfo.pagescount+1; i++) {
        // add anchor tag with the page number for each page.
        var anchor = $("<a style='padding: 5px;' href='#" + i + "'>" + i + "</a>");
        anchor.appendTo(element);
        anchor.click(function (event) {
            // go to a page.
            var pagenum = parseInt($(event.target).text());
            $("#jqxgrid").jqxGrid('gotopage', pagenum);
                });
            }
            
    return element;
}

var pagerrenderer = function () {
    var element = $("<div style='margin-top: 5px; width: 100%; height: 100%;'></div>");
    var paginginfo = $("#jqxgrid").jqxGrid('getpaginginformation');
    for (i = 0; i < paginginfo.pagescount; i++) {
        // add anchor tag with the page number for each page.
        var anchor = $("<a style='padding: 5px;' href='#" + i + "'>" + i + "</a>");
        anchor.appendTo(element);
        anchor.click(function (event) {
            // go to a page.
            var pagenum = parseInt($(event.target).text());
            $("#jqxgrid").jqxGrid('gotopage', pagenum);
        });
    }
    return element;
}
