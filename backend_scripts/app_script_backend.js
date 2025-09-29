function doGet(e) {
  var type = e.parameter.type;

  if (type === "drivers") {
    const documento = e.parameter.documento;
    return getDriverByDocumento(documento);
  }

  const driverId = e.parameter.driverId ? String(e.parameter.driverId).trim() : null;
  if (!driverId) {
    return ContentService.createTextOutput(
      JSON.stringify({ error: "driverId required" })
    ).setMimeType(ContentService.MimeType.JSON);
  }

  if (type === "reportes") {
    const days = e.parameter.days ? parseInt(e.parameter.days, 10) : 14;
    return getReportes(driverId, days);
  }
  if (type === "pagos") return getPagos(driverId);
  if (type === "balance") return getBalance(driverId);
  if (type === "goal_bonus") return getGoalBonus(driverId);
  if (type === "reporte_semanal") return getReporteSemanal(driverId);

  return ContentService.createTextOutput(
    JSON.stringify({ error: "Invalid type" })
  ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 DRIVER LOOKUP
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
          conductor_id: String(row[idIdx]).trim(),
          conductor: row[nameIdx],
          documento: row[docIdx],
        })
      ).setMimeType(ContentService.MimeType.JSON);
    }
  }

  return ContentService.createTextOutput(
    JSON.stringify({})
  ).setMimeType(ContentService.MimeType.JSON);
}

/**
 * 🔹 REPORTES
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

  return ContentService.createTextOutput(
    JSON.stringify({
      conductor_id: driverId,
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
  return getBySheet("pagos", driverId);
}

/**
 * 🔹 BALANCE
 */
function getBalance(driverId) {
  return getBySheet("balance", driverId);
}

/**
 * 🔹 GOAL BONUS
 */
function getGoalBonus(driverId) {
  return getBySheet("goal_bonus", driverId);
}

/**
 * 🔹 REPORTE SEMANAL
 */
function getReporteSemanal(driverId) {
  return getBySheet("reporte_semanal", driverId);
}

/**
 * 🔹 Generic sheet reader
 */
function getBySheet(sheetName, driverId) {
  const ss = SpreadsheetApp.getActiveSpreadsheet();
  const sheet = ss.getSheetByName(sheetName);
  const values = sheet.getDataRange().getValues();
  const headers = values[0];
  const idIdx = headers.indexOf("conductor_id");

  const rows = values.slice(1).filter(row =>
    String(row[idIdx]).trim() === driverId
  );

  return ContentService.createTextOutput(
    JSON.stringify(rows.map(r => {
      const obj = {};
      headers.forEach((h, i) => obj[h] = r[i] ?? 0);
      return obj;
    }))
  ).setMimeType(ContentService.MimeType.JSON);
}