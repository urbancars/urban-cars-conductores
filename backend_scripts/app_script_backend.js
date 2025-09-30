function doGet(e) {
    var type = e.parameter.type;

    if (type === "drivers") {
        const documento = e.parameter.documento;
        return getDriverByDocumento(documento);
    }

    if (type === "reportes") {
        const driverId = e.parameter.driverId;
        const days = e.parameter.days ? parseInt(e.parameter.days) : 7;
        return getReportes(driverId, days);
    }

    if (type === "pagos") {
        const driverId = e.parameter.driverId;
        return getPagos(driverId);
    }

    if (type === "balance") {
        const driverId = e.parameter.driverId;
        return getBalance(driverId);
    }

    if (type === "goal_bonus") {
        const driverId = e.parameter.driverId;
        return getGoalBonus(driverId);
    }

    if (type === "reporte_semanal") {
        const driverId = e.parameter.driverId;
        return getReporteSemanal(driverId);
    }

    return ContentService.createTextOutput(
        JSON.stringify({ error: "Invalid type" })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 DRIVER LOOKUP BY DOCUMENTO
 */
function getDriverByDocumento(documento) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("drivers");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];

    const idIdx = headers.indexOf("id");
    const nameIdx = headers.indexOf("conductor");
    const docIdx = headers.indexOf("documento");

    for (let i = 1; i < values.length; i++) {
        const row = values[i];
        if (String(row[docIdx]).trim() === String(documento).trim()) {
            return ContentService.createTextOutput(
                JSON.stringify({
                    driver: {
                        conductor_id: row[idIdx],
                        conductor: row[nameIdx],
                        documento: row[docIdx],
                    }
                })
            ).setMimeType(ContentService.MimeType.JSON);
        }
    }

    return ContentService.createTextOutput(
        JSON.stringify({ driver: null })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 REPORTES — FILTER BY DRIVER ID & LAST N DAYS
 */
function getReportes(driverId, days) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("reportes");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];

    const idIdx = headers.indexOf("conductor_id");
    const dateIdx = headers.indexOf("fecha");

    const today = new Date();
    const cutoff = new Date(today.getTime() - days * 24 * 60 * 60 * 1000);

    const rows = values.slice(1).filter(row => {
        const rowId = String(row[idIdx]).trim();
        const fecha = new Date(row[dateIdx]);
        return rowId === String(driverId).trim() && fecha >= cutoff;
    });

    // 🔹 Sort rows by date descending (newest first)
    rows.sort((a, b) => new Date(b[dateIdx]) - new Date(a[dateIdx]));

    return ContentService.createTextOutput(
        JSON.stringify({
            reportes: rows.map(r => {
                const obj = {};
                headers.forEach((h, i) => obj[h] = r[i]);
                return obj;
            })
        })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 PAGOS
 */
function getPagos(driverId) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("pagos");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];
    const idIdx = headers.indexOf("conductor_id");

    const rows = values.slice(1).filter(row =>
        String(row[idIdx]).trim() === String(driverId).trim()
    );

    return ContentService.createTextOutput(
        JSON.stringify({
            pagos: rows.map(r => {
                const obj = {};
                headers.forEach((h, i) => obj[h] = r[i]);
                return obj;
            })
        })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 BALANCE
 */
function getBalance(driverId) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("balance");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];
    const idIdx = headers.indexOf("conductor_id");

    const rows = values.slice(1).filter(row =>
        String(row[idIdx]).trim() === String(driverId).trim()
    );

    return ContentService.createTextOutput(
        JSON.stringify({
            balance: rows.map(r => {
                const obj = {};
                headers.forEach((h, i) => obj[h] = r[i]);
                return obj;
            })
        })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 GOAL BONUS
 */
function getGoalBonus(driverId) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("goal_bonus");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];
    const idIdx = headers.indexOf("conductor_id");

    const rows = values.slice(1).filter(row =>
        String(row[idIdx]).trim() === String(driverId).trim()
    );

    return ContentService.createTextOutput(
        JSON.stringify({
            goal_bonus: rows.map(r => {
                const obj = {};
                headers.forEach((h, i) => obj[h] = r[i]);
                return obj;
            })
        })
    ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 REPORTE SEMANAL
 */
function getReporteSemanal(driverId) {
    const ss = SpreadsheetApp.getActiveSpreadsheet();
    const sheet = ss.getSheetByName("reporte_semanal");
    const values = sheet.getDataRange().getValues();
    const headers = values[0];
    const idIdx = headers.indexOf("conductor_id");

    const rows = values.slice(1).filter(row =>
        String(row[idIdx]).trim() === String(driverId).trim()
    );

    return ContentService.createTextOutput(
        JSON.stringify({
            reporte_semanal: rows.map(r => {
                const obj = {};
                headers.forEach((h, i) => obj[h] = r[i]);
                return obj;
            })
        })
    ).setMimeType(ContentService.MimeType.JSON);
}