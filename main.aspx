<%@ Page Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="True" CodeBehind="main.aspx.cs" Inherits="StudentPatrol.main" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="Styles/page.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" href="Scripts/themes/base/jquery.ui.all.css" />
    
    <script type="text/javascript" src="Scripts/ui/jquery.ui.core.js"></script>
    <script type="text/javascript" src="Scripts/ui/jquery.ui.widget.js"></script>
    <script type="text/javascript" src="Scripts/ui/jquery.ui.mouse.js"></script>
    <script type="text/javascript" src="Scripts/ui/jquery.ui.resizable.js"></script>
    <script type="text/javascript" src="Scripts/ui/jquery.ui.accordion.js"></script>
    <script type="text/javascript" src="Scripts/ui/jquery.ui.datepicker.js"></script>
    <script type="text/javascript" src="ajax.js"></script>


    <!--<link rel="stylesheet" href="Scripts/css/demos.css" />-->

    <style type="text/css">
        #accordion-resizer {
            padding: 2px;
            width: 390px;
            height: 370px;
            border: none;
        }

        #testovertop {
            position: absolute;
            top: 0px;
            left: 500px;
            height: 200px;
            width: 600px;
            z-index: -10000;
        }

        #datepicker1 {
            position: relative;
            z-index: 7000;
            width: 64px;
        }

        #datepicker2 {
            position: relative;
            z-index: 7000;
            width: 64px;
        }

        #selStudentReportInfo {
            position: relative;
            z-index: 7000;
            width: 200px;
        }

        #CurrentLocationLabel {
            position: absolute;
            top: 339px;
            left: 2px;
            z-index: 7500;
            padding: 3.5px;
            background-color: rgba(255, 255, 255, 0.6);
            box-shadow: 0 0 4px #888888;
            width: 360px;
            display: block;
            padding-bottom: -3px;
        }

        #TimeChecker {
            position: absolute;
            top: 339px;
            left: 2px;
            z-index: 12000000;
            padding: 3px;
            background-color: red;
            height: 20px;
            width: 360px;
            display: block;
            padding-bottom: -3px;
            display: none;
        }




        /*
        when OL encounters a 404, don't display the pink image 

	        .olImageLoadError { 
                
                display: none !important;
            }
            
          */
    </style>

    <script type="text/javascript">

        /*
         $(document).ready(function() {
            $('#selIncidents').change(function(){
                var mySelection = $(this).val(),
                div = $('#' + mySelection);

                //$('div').hide();
                   // div.show();

            });
        });​
        */


        $(function () {

            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();

        });


        function donothing(eventTarget, eventArgument) {
            //Just swallow the click without postback of the form
        }

        function removeTracking() {
            //alert(document.getElementById("ReportName").value);
            document.getElementById('ResultListMain').innerHTML = '';
        }

        function showdata() {
            //alert(document.getElementById('MapPanel').innerHTML);
            alert(zoom);
        }


        function checkfordata() {


            //alert('hello');
            //alert(document.getElementById('TestLabel').innerHTML);

            if (document.getElementById('TestLabel').innerHTML == '') {
                //alert('return false');

                //alert(document.getElementById("ReportName").value);

                if (document.getElementById("ReportName").value == "Student Tracking") {
                    return true;
                }
                else {
                    return false;
                }

            }
            else {
                //alert('return true');
                //alert(document.getElementById("ReportName").value);
                return true;
            }
        }



        // window.onload = pageLoad;


        $(document).ready(function () {

            //alert($("#CurrentLocationLabel").text());

            if ($("#CurrentLocationLabel").text() == "") {

                $("#CurrentLocationLabel").hide()

            }
            else {
                $("#CurrentLocationLabel").show()
            }

            var prm = Sys.WebForms.PageRequestManager.getInstance();

            prm.add_initializeRequest(InitializeRequest);

            prm.add_endRequest(EndRequest);

            BindControls();


        });

        function InitializeRequest(sender, args) { }

        function EndRequest(sender, args) { BindControls(); }

        function BindControls() {

            $(function () {
                $("#accordion").accordion({
                    heightStyle: "fill"
                });
            });
            $(function () {
                $("#accordion-resizer").resizable({
                    minHeight: 330,
                    minWidth: 390,
                    maxHeight: 330,
                    maxWidth: 390
                    // resize: function () {
                    //     $("#accordion").accordion("refresh");
                    // }
                });
            });

        }




        /*
        * hoverIntent | Copyright 2011 Brian Cherne
        * http://cherne.net/brian/resources/jquery.hoverIntent.html
        * modified by the jQuery UI team
        */
        $.event.special.hoverintent = {
            setup: function () {
                $(this).bind("mouseover", jQuery.event.special.hoverintent.handler);
            },
            teardown: function () {
                $(this).unbind("mouseover", jQuery.event.special.hoverintent.handler);
            },
            handler: function (event) {
                var currentX, currentY, timeout,
                    args = arguments,
                    target = $(event.target),
                    previousX = event.pageX,
                    previousY = event.pageY;

                function track(event) {
                    currentX = event.pageX;
                    currentY = event.pageY;
                };

                function clear() {
                    target
                        .unbind("mousemove", track)
                        .unbind("mouseout", clear);
                    clearTimeout(timeout);
                }

                function handler() {
                    var prop,
                        orig = event;

                    if ((Math.abs(previousX - currentX) +
                        Math.abs(previousY - currentY)) < 7) {
                        clear();

                        event = $.Event("hoverintent");
                        for (prop in orig) {
                            if (!(prop in event)) {
                                event[prop] = orig[prop];
                            }
                        }
                        // Prevent accessing the original event since the new event
                        // is fired asynchronously and the old event is no longer
                        // usable (#6028)
                        delete event.originalEvent;

                        target.trigger(event);
                    } else {
                        previousX = currentX;
                        previousY = currentY;
                        timeout = setTimeout(handler, 100);
                    }
                }

                timeout = setTimeout(handler, 100);
                target.bind({
                    mousemove: track,
                    mouseout: clear
                });
            }
        };

    </script>

    <style>
        #mapTester {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 50px;
            height: 20px;
            background-color: Red;
            z-index: 1000000;
        }

        #mapTester2 {
            display: none;
            position: fixed;
            top: 0;
            right: 20;
            width: 150px;
            height: 20px;
            background-color: blue;
            z-index: 1000000;
        }

        #ButtonClicker {
            display: none;
        }
    </style>



</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="SiteHeader" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <div id="testovertop"></div>

    <asp:Label ID="testinfo" runat="server"></asp:Label>

    <div id="MainContent">

        <!--<asp:Button ID="Button5" OnClientClick="showdata()" runat="server"></asp:Button>-->

        <asp:Label ID="AlertLabel" CssClass="centered" runat="server"></asp:Label>

        <asp:Label ID="lblBrowser" runat="server"></asp:Label>

        <script type="text/javascript" src="ol.js"></script>

        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <!--<script type="text/javascript" src="Scripts/jquery-1.4.1.js"></script>-->

        <asp:UpdatePanel ID="MapPanel" runat="server" UpdateMode="Conditional" ClientIDMode="Static">

            <ContentTemplate>

                <script type="text/javascript" src="Scripts/ui/browserdetection.js"></script>
                <script type="text/javascript">



                    var travelingstatus = 0;
                    var myVar;
                    var strTester;



                    function pageLoad() {


                        $('#selStudentReportInfo').change(function () {

                            var mySelection = $("#selStudentReportInfo").val();
                            div = $('#div' + mySelection);

                            $('div[id^=divincident]').hide();

                            //alert(mySelection.toString());

                            if (mySelection.toString() == "") {
                                $('div[id^=divincident]').show();
                            }
                            else {
                                div.show();
                            }

                        });

                        /////////

                        var e = document.getElementById("DropDownList3");

                        var strStudentId = "0";

                        //commented on 3/20/2018 from Anjali

                        //if (e !='undefined') {
                        strStudentId = '305';
                        //}




                        var currentdate = new Date();
                        var datetime = currentdate.getHours() + ":" + currentdate.getMinutes() + ":" + currentdate.getSeconds() + " ";


                        if (strStudentId != "0") {
                            // alert(myVar);
                            if (undefined == myVar) {
                                myVar = setInterval(checktravel, 5000);
                            }
                        }


                        function checktravel() {
                           
                            var hand = function (str) {

                                travelingstatus = str;

                                console.log(datetime + 'str: ' + str);

                                //alert('step1');

                            }

                            var ajax = new Ajax();

                            //alert('ajaxquery.aspx?Q=travel&S=' + strStudentId );
                            var requestlink = "ajaxquery.aspx?Q=travel&S=" + strStudentId;


                            ajax.doGet(requestlink, hand);

                            //alert('step2');

                            //alert(requestlink);

                            //console.log('Status: ' + travelingstatus);


                            if (travelingstatus == 0) {
                                //$('#mapTester2').empty();
                                //$('#mapTester2').html("");
                                //alert('here');

                                if (strTester != "") {
                                    $('#map').empty();
                                    $('#map').html(strTester);
                                }
                            }

                            if (travelingstatus == 1) {
                                //server side post

                                clearInterval(myVar);
                                myVar = undefined;

                                document.getElementById('ButtonClicker').click();

                                strTester = document.getElementById('mapTester2').innerHTML;

                                // strTester = document.getElementById('mapTrackerData').value;

                                console.log('InnerHTML: ' + strTester);

                                // $('#mapTester2').empty();
                                // $('#mapTester2').html("");

                                //$('#mapTester').empty();
                                //$('#mapTester').html(strTester);

                                if (strTester != "") {
                                    $('#map').empty();
                                    $('#map').html(strTester);
                                }


                            }

                        }

                    }

                        /*
                        var prm = Sys.WebForms.PageRequestManager.getInstance();

                        prm.add_endRequest(function () {

                            // alert('now');
                            //console.log('endRequest: ' + strTester);
                            //$('#map').empty();
                            //$('#map').html(strTester);

                        });
                        */

                </script>

                <asp:HiddenField ID="TimerOnOff" Value="off" runat="server" />

                <asp:HiddenField ID="UpdateMap" Value="off" runat="server" />

                <asp:HiddenField ID="SavedMapData" Value="" runat="server" />

                <div style="width: 550px; height: 360px" id="map" runat="server"></div>

                <asp:Label ID="CurrentLocationLabel" runat="server"></asp:Label>
                <!--<script defer="defer" type="text/javascript"></script>-->

                <div id="mapTester" runat="server">
                </div>


            </ContentTemplate>

            <%-- <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="myTimer" />
                    </Triggers>--%>
        </asp:UpdatePanel>

        <%--<asp:Timer id="myTimer" runat="server" Interval="110000" OnTick="myTimer_Tick" ClientIdMode="Predictable"></asp:Timer>--%>


        <asp:UpdatePanel ID="UpdatePanelTest" runat="server" ChildrenAsTriggers="true">

            <ContentTemplate>

                <asp:Label runat="server" ID="TimeChecker" />


                <asp:HiddenField ID="mapTrackerData" Value="" runat="server" />
                <asp:Button runat="server" ID="ButtonClicker" OnClick="myTimer_Tick" />


                <div id="mapTester2" runat="server"></div>

            </ContentTemplate>

            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ButtonClicker" />
            </Triggers>

        </asp:UpdatePanel>




        <table id="tblSelections">

            <tr>
                <td>
                    <asp:LinkButton ID="linkSchool" CssClass="linkbutton" runat="server" OnClick="linkSchool_Click">School</asp:LinkButton>
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" AutoPostBack="true" runat="server" CssClass="tblSelectionLength" OnSelectedIndexChanged="myListDropDown1_Change">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:LinkButton ID="linkBus" CssClass="linkbutton" runat="server" OnClick="linkBus_Click">Bus</asp:LinkButton>
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList2" AutoPostBack="true" runat="server" CssClass="tblSelectionLength" OnSelectedIndexChanged="myListDropDown2_Change">
                    </asp:DropDownList>
                </td>
            </tr>

            <tr>
                <td>
                    <asp:LinkButton ID="linkStudent" CssClass="linkbutton" runat="server" OnClick="linkStudent_Click">Student&nbsp;</asp:LinkButton>
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList3" AutoPostBack="true" runat="server" CssClass="tblSelectionLength" OnSelectedIndexChanged="myListDropDown3_Change">
                    </asp:DropDownList>
                </td>
            </tr>

        </table>

        <div id="HorizontalBar4" class="orangefader"></div>

        <div id="ResultInfo" style="display: inline;">

            <asp:Label ID="HeadingLabel1" CssClass="HeadingLabel" runat="server">
            </asp:Label>

            <asp:Label ID="InfoLabel1a" CssClass="InfoLabel" runat="server">
            </asp:Label>

            <asp:Label ID="InfoLabel1b" CssClass="InfoLabel" runat="server">
            </asp:Label>

            <asp:Label ID="InfoLabel1c" CssClass="InfoLabel" runat="server">
            </asp:Label>

            <asp:Label ID="InfoLabel1d" CssClass="InfoLabel" runat="server">
            </asp:Label>

            <asp:Label ID="HeadingLabel2" CssClass="HeadingLabel" runat="server">
            </asp:Label>

            <asp:Image ID="SpecialNeeds1" runat="server"></asp:Image>

            <asp:Image ID="SpecialNeeds2" runat="server"></asp:Image>

            <asp:Image ID="SpecialNeeds3" runat="server"></asp:Image>

            <asp:Image ID="Photo1" runat="server"></asp:Image>


            <asp:Table runat="server" Width="400" ID="tblStudentIcons" Visible="false">

                <asp:TableHeaderRow ID="TableHeaderRow1" runat="server">

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent0" runat="server" title="Tracking Information" ImageUrl="images/studentpatrol.png" OnClick="imgStudent0_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent1" runat="server" Title="Student Information" ImageUrl="images/user.png" OnClientClick="removeTracking();" OnClick="imgStudent1_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent2" runat="server" Title="Routing Information" ImageUrl="images/school_bus.png" OnClientClick="removeTracking();" OnClick="imgStudent2_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent3" runat="server" Title="Guardian Information" ImageUrl="images/users.png" OnClientClick="removeTracking();" OnClick="imgStudent3_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent4" runat="server" Title="Medical Information" ImageUrl="images/health_care_shield.png" OnClientClick="removeTracking();" OnClick="imgStudent4_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent5" runat="server" Title="Incident Information" ImageUrl="images/splash green.png" OnClientClick="removeTracking();" OnClick="imgStudent5_Click" />
                    </asp:TableHeaderCell>

                    <%--
                        <asp:TableHeaderCell>
                            <asp:ImageButton id="imgStudent6" runat="server" Title="Reports" ImageUrl="images/report.png" OnClientClick="removeTracking();" OnClick="imgStudent6_Click" />
                        </asp:TableHeaderCell>
                        ----%>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent7" runat="server" Title="Alert Information" ImageUrl="images/urgent.png" OnClientClick="removeTracking();" OnClick="imgStudent7_Click" />
                    </asp:TableHeaderCell>

                    <asp:TableHeaderCell>
                        <asp:ImageButton ID="imgStudent8" runat="server" Title="Save PDF" ImageUrl="images/save.png" OnClientClick="if (checkfordata() == false) return(false);" OnClick="imgStudent8_Click" />
                    </asp:TableHeaderCell>

                </asp:TableHeaderRow>
            </asp:Table>


            <asp:Label ID="lblStudentReportInfo" runat="server"></asp:Label>

            <div id="ResultList">

                <div runat="server" id="ResultListReports">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Conditional">

                        <ContentTemplate>

                            <asp:HiddenField ID="ReportName" Value="" runat="server" />
                            <asp:Label ID="TestLabel" runat="server"></asp:Label>
                            <asp:HiddenField ID="MissingReportInfo" Value="" runat="server" />

                        </ContentTemplate>

                        <Triggers>

                            <asp:AsyncPostBackTrigger ControlID="imgStudent1" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="imgStudent2" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="imgStudent3" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="imgStudent4" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="imgStudent5" EventName="Click" />
                            <%--
                            <asp:AsyncPostBackTrigger ControlID="imgStudent6" EventName="Click" />
                            --%>

                            <asp:AsyncPostBackTrigger ControlID="imgStudent7" EventName="Click" />

                        </Triggers>

                    </asp:UpdatePanel>

                </div>

                <div runat="server" id="ResultListMain">

                    <asp:Menu ID="BusListMenuControl" runat="server" CssClass="mGrid" OnMenuItemClick="BusListMenuControl_MenuItemClick"></asp:Menu>

                    <asp:Menu ID="StudentListMenuControl" runat="server" CssClass="mGrid" OnMenuItemClick="StudentListMenuControl_MenuItemClick"></asp:Menu>

                    <asp:Label ID="lblStudentTrackingHeading" runat="server"></asp:Label>

                    <%--
                            <asp:DropDownList ID="selTrackingRange" AutoPostBack="true" runat="server" Visible="false" OnSelectedIndexChanged="selTrackingRange_Change">
                            </asp:DropDownList>
                    --%>



                    <%
                        if (DropDownList3.SelectedValue.ToString() != "0")
                        {
                    %>
                            &nbsp;from
                            <asp:TextBox runat="server" type="text" ID="datepicker1" OnTextChanged="datepicker1_Changed" AutoPostBack="True"></asp:TextBox>

                    to
                            <asp:TextBox runat="server" type="text" ID="datepicker2" OnTextChanged="datepicker2_Changed" AutoPostBack="True"></asp:TextBox>
                    <%
                        }
                    %>


                    <asp:Label ID="InfoLabel2a" CssClass="InfoLabel" runat="server">
                    </asp:Label>

                    <asp:GridView ID="TrackingGrid" runat="server" Visible="false" AutoGenerateColumns="false"
                        OnRowDataBound="TrackingGrid_RowDataBound" OnRowCommand="TrackingGrid_RowCommand"
                        CssClass="mGrid" AlternatingRowStyle-CssClass="alt">
                        <Columns>

                            <%--
                                <asp:TemplateField HeaderText="Example">
                                <ItemTemplate>
                                    <asp:ImageButton runat="server" ID="imgTrackingButton" CausesValidation="False" ImageUrl="images/school_bus.png" CommandName="UpdateTracking"  OnClientClick="return donothing();" />
                                </ItemTemplate>
                                </asp:TemplateField>
                            --%>

                            <asp:BoundField DataField="Longitude" />
                            <asp:BoundField DataField="Latitude" />
                            <asp:BoundField DataField="LocationType" />

                            <asp:ButtonField ButtonType="Image" ImageUrl="" CommandName="UpdateTracking" />

                            <asp:BoundField DataField="Description" HeaderText="Location" />

                            <asp:BoundField DataField="EncounterDateTime" HeaderText="Time" />
                            <asp:BoundField DataField="BusNumber" HeaderText="Bus" />

                        </Columns>
                    </asp:GridView>

                </div>

            </div>

        </div>

        <div id="AlertDiv">

            <asp:UpdatePanel ID="AlertPanel" runat="server" UpdateMode="Conditional">

                <ContentTemplate>

                    <asp:Button ID="Alert1" Text=" Alerts " runat="server" OnClick="Alert1_Click" />
                    <asp:Button ID="Alert2" Text="Alert Summary" runat="server" OnClick="Alert2_Click" />

                    <asp:Timer ID="Timer1" runat="server" Interval="120000" OnTick="Timer1_Tick" ClientIDMode="Predictable"></asp:Timer>
                    <asp:Label ID="TimerCount" runat="server"></asp:Label>
                    <asp:Label ID="lblAlerts" runat="server"></asp:Label>

                    <asp:GridView ID="GridView1" CssClass="mGrid" runat="server" AutoGenerateColumns="false">
                        <Columns>

                            <asp:ImageField DataImageUrlField="alertimage"></asp:ImageField>

                            <asp:TemplateField>
                                <HeaderTemplate>Alert Count</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="PostBackButton" OnDataBinding="PostBackBind_DataBinding" OnCommand="alertcount_Click" CommandName="alertcountlink" CommandArgument='<%# Eval("AlertTypeId")%>' runat="server"><%# Eval("alertcount")%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="alertcount" HeaderText="Alert Count" />

                            <asp:BoundField DataField="alerttypedescription" HeaderText="Alert Type" />

                        </Columns>
                    </asp:GridView>


                    <asp:GridView ID="GridView2" CssClass="mGrid" runat="server" AllowPaging="false" AllowSorting="false" AutoGenerateColumns="false">
                        <Columns>

                            <asp:TemplateField>
                                <HeaderTemplate>Student</HeaderTemplate>
                                <ItemTemplate>
                                    <asp:LinkButton ID="PostBackButton" OnDataBinding="PostBackBind_DataBinding" OnCommand="alertLinkStudent_Click" CommandName="alertstudentlink" CommandArgument='<%# Eval("StudentId")%>' runat="server"><%# Eval("StudentName")%></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="BusNumber" HeaderText="Bus" />
                            <asp:BoundField DataField="AlertDateTime" HeaderText="Time" />
                            <asp:BoundField DataField="AlertTypeDescription" HeaderText="Description" />
                        </Columns>
                    </asp:GridView>

                    <triggers>
                                <asp:PostBackTrigger ControlID="PostBackButton" />
                            </triggers>

                </ContentTemplate>

            </asp:UpdatePanel>

        </div>

        <asp:Label ID="txtTestLabel10" runat="server">
        </asp:Label>

        <asp:Label ID="txtTestLabel11" runat="server">
        </asp:Label>










    </div>

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="SiteFooter" runat="server">
    <asp:Label ID="lblError" runat="server"></asp:Label>
</asp:Content>
