
<html>
    <head><script type="text/javascript">
        function Reset()
        {
            api.getSession(function (session) {
                api.call("Get", {
                    typeName: "User",
                    search: {
                        name: session.userName
                    }
                }, function (result) {
                    console.log(result)
                }, function (err) {
                    console.log("error getting user", err)
                });
            });
        }
</script></head>
<body>
    <div style="height:1200px;width:1000px">
        <iframe src="https://Apps.busboss.com/test/studentpatrol" style="height:1200px;width:1000px">
            <p>Your browser does not support iframes.</p>
        </iframe>
    </div>

</body>
</html>
