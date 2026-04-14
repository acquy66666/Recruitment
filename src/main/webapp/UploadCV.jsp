<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload CV</title>
</head>
<body>
    <h2>Upload CV (PDF)</h2>
    <form id="cvForm">
        <input type="file" name="cvFile" id="cvFile" accept="application" required>
        <button type="submit">Tải lên</button>
    </form>
    <pre id="result"></pre>

    <script>
        document.getElementById("cvForm").addEventListener("submit", async function (e) {
            e.preventDefault();
            const formData = new FormData();
            formData.append("cvFile", document.getElementById("cvFile").files[0]);

            const res = await fetch("CVReg", {
                method: "POST",
                body: formData
            });

            const data = await res.json();
            document.getElementById("result").textContent = JSON.stringify(data, null, 2);
        });
    </script>
</body>
</html>
