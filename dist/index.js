import { jsxs as n, jsx as e, Fragment as J } from "react/jsx-runtime";
import K, { useState as v, useEffect as P, useRef as Q } from "react";
import { ShieldCheck as Z, ArrowUpRight as V, ArrowDownRight as ee, Copy as ne, Edit2 as ie, Trash2 as E, ArrowUp as re, ArrowDown as te, ArrowUpDown as oe, AlertTriangle as B, X as C, Info as le, AlertCircle as N, CheckCircle2 as T, Filter as de, Search as se, SlidersHorizontal as ae, Phone as ce, User as $, Lock as L, EyeOff as U, Eye as M, LogIn as pe, Save as fe, GraduationCap as ge, Users as xe, ArrowUpCircle as O, RefreshCw as H, ChevronDown as be, Settings as me, LogOut as he } from "lucide-react";
import { createPortal as I } from "react-dom";
const we = ({ status: r = "completed", label: i, className: t = "", style: o }) => {
  const l = {
    completed: { text: i || "Completed", class: "success" },
    registered: { text: i || "Registered", class: "success" },
    active: { text: i || "Active", class: "success" },
    paid: { text: i || "Paid", class: "success" },
    present: { text: i || "Present", class: "success" },
    pending: { text: i || "Pending", class: "warning" },
    in_consultation: { text: i || "In Consultation", class: "warning" },
    under_review: { text: i || "Under Review", class: "warning" },
    partially_paid: { text: i || "Partially Paid", class: "warning" },
    unregistered: { text: i || "Unregistered", class: "danger" },
    critical: { text: i || "Critical", class: "danger" },
    absent: { text: i || "Absent", class: "danger" },
    failed: { text: i || "Failed", class: "danger" },
    suspended: { text: i || "Suspended", class: "danger" },
    unpaid: { text: i || "Unpaid", class: "danger" },
    inactive: { text: i || "Inactive", class: "info" },
    draft: { text: i || "Draft", class: "info" }
  }, d = typeof r == "string" ? r.toLowerCase().replace(/\s+/g, "_") : "info", c = l[d] || { text: i || r, class: "info" };
  return /* @__PURE__ */ n("span", { className: `orion-status-pill ${c.class} ${t}`, style: o, children: [
    /* @__PURE__ */ e("span", { className: "orion-status-pill-dot" }),
    c.text
  ] });
}, Ie = ({ severity: r = "minor", label: i, className: t = "", style: o }) => {
  const l = {
    minor: { label: i || "Minor Severity", class: "success" },
    low: { label: i || "Low Risk", class: "success" },
    moderate: { label: i || "Moderate Severity", class: "warning" },
    medium: { label: i || "Medium Risk", class: "warning" },
    major: { label: i || "Major Severity", class: "danger" },
    high: { label: i || "High Risk", class: "danger" },
    critical: { label: i || "Critical Severity", class: "danger" }
  }, d = typeof r == "string" ? r.toLowerCase().trim() : "minor", c = l[d] || l.minor;
  return /* @__PURE__ */ n("span", { className: `orion-status-pill ${c.class} ${t}`, style: o, children: [
    /* @__PURE__ */ e("span", { className: "orion-status-pill-dot" }),
    c.label
  ] });
}, Re = ({
  role: r = "Super Admin",
  permissionsCount: i,
  customText: t,
  className: o = "",
  style: l
}) => /* @__PURE__ */ n(
  "div",
  {
    className: `orion-permissions-badge ${o}`,
    style: {
      display: "inline-flex",
      alignItems: "center",
      gap: "8px",
      background: "#e5f3f7",
      color: "#02658b",
      padding: "6px 14px",
      borderRadius: "9999px",
      fontSize: "0.82rem",
      fontWeight: 700,
      border: "1.5px solid #bfdbfe",
      boxShadow: "0 1px 2px rgba(2,101,139,0.05)",
      ...l
    },
    children: [
      /* @__PURE__ */ e(Z, { size: 16, strokeWidth: 2.4 }),
      /* @__PURE__ */ e("span", { children: t || `${r}${i !== void 0 ? ` (${i} Permissions)` : ""}` })
    ]
  }
), We = ({
  title: r,
  value: i,
  change: t,
  changeType: o = "up",
  icon: l,
  subtitle: d,
  className: c = "",
  style: s,
  onClick: a
}) => /* @__PURE__ */ n(
  "div",
  {
    className: `orion-stat-card ${c}`,
    onClick: a,
    style: {
      background: "#FFFFFF",
      border: "1.5px solid #cbd5e1",
      borderRadius: "10px",
      padding: "1.25rem",
      boxShadow: "0 1px 3px rgba(0,0,0,0.03)",
      display: "flex",
      flexDirection: "column",
      gap: "0.5rem",
      cursor: a ? "pointer" : "default",
      ...s
    },
    children: [
      /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "center" }, children: [
        /* @__PURE__ */ e("span", { style: { fontSize: "0.84rem", color: "#64748b", fontWeight: 600 }, children: r }),
        l && /* @__PURE__ */ e("div", { style: { color: "#02658b", background: "#e5f3f7", padding: "6px", borderRadius: "6px", display: "flex" }, children: l })
      ] }),
      /* @__PURE__ */ e("div", { style: { fontSize: "1.8rem", fontWeight: 800, color: "#0f172a", letterSpacing: "-0.02em" }, children: i }),
      (t || d) && /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "6px", fontSize: "0.8rem" }, children: [
        t && /* @__PURE__ */ n(
          "span",
          {
            style: {
              color: o === "up" ? "#10b981" : "#ef4444",
              fontWeight: 700,
              display: "inline-flex",
              alignItems: "center",
              gap: "2px"
            },
            children: [
              o === "up" ? /* @__PURE__ */ e(V, { size: 14 }) : /* @__PURE__ */ e(ee, { size: 14 }),
              t
            ]
          }
        ),
        d && /* @__PURE__ */ e("span", { style: { color: "#94a3b8" }, children: d })
      ] })
    ]
  }
), Ne = ({ label: r, count: i, icon: t, className: o = "", style: l, onClick: d }) => /* @__PURE__ */ n(
  "div",
  {
    className: `orion-counter-card ${o}`,
    onClick: d,
    style: {
      background: "#FFFFFF",
      border: "1.5px solid #cbd5e1",
      borderRadius: "8px",
      padding: "0.9rem 1.15rem",
      display: "flex",
      alignItems: "center",
      gap: "0.85rem",
      boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
      cursor: d ? "pointer" : "default",
      ...l
    },
    children: [
      t && /* @__PURE__ */ e(
        "div",
        {
          style: {
            background: "#e5f3f7",
            color: "#02658b",
            padding: "8px",
            borderRadius: "8px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            flexShrink: 0
          },
          children: t
        }
      ),
      /* @__PURE__ */ n("div", { children: [
        /* @__PURE__ */ e("div", { style: { fontSize: "1.35rem", fontWeight: 800, color: "#0f172a", lineHeight: 1.1 }, children: i }),
        /* @__PURE__ */ e("div", { style: { fontSize: "0.78rem", color: "#64748b", fontWeight: 600 }, children: r })
      ] })
    ]
  }
), $e = ({
  user: r = {},
  onEdit: i,
  onDelete: t,
  onCopyInvite: o,
  className: l = "",
  style: d
}) => {
  const { name: c = "User Name", email: s = "user@example.com", role: a = "User", phoneNumber: f, cnic: x } = r, p = c ? c.substring(0, 2).toUpperCase() : "U";
  return /* @__PURE__ */ n(
    "div",
    {
      className: `orion-user-details-card ${l}`,
      style: {
        background: "#FFFFFF",
        border: "1.5px solid #cbd5e1",
        borderRadius: "10px",
        padding: "1.25rem",
        display: "flex",
        alignItems: "center",
        justifyContent: "space-between",
        boxShadow: "0 1px 3px rgba(0,0,0,0.03)",
        flexWrap: "wrap",
        gap: "1rem",
        ...d
      },
      children: [
        /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "12px" }, children: [
          /* @__PURE__ */ e(
            "div",
            {
              style: {
                width: "46px",
                height: "46px",
                borderRadius: "50%",
                backgroundColor: "#02658b",
                color: "#FFFFFF",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontWeight: 800,
                fontSize: "1rem",
                flexShrink: 0
              },
              children: p
            }
          ),
          /* @__PURE__ */ n("div", { children: [
            /* @__PURE__ */ e("div", { style: { fontWeight: 700, fontSize: "0.98rem", color: "#0f172a" }, children: c }),
            /* @__PURE__ */ n("div", { style: { fontSize: "0.82rem", color: "#64748b", display: "flex", alignItems: "center", gap: "8px", flexWrap: "wrap" }, children: [
              /* @__PURE__ */ e("span", { children: s }),
              /* @__PURE__ */ e("span", { children: "•" }),
              /* @__PURE__ */ e("span", { style: { color: "#02658b", fontWeight: 700, background: "#e5f3f7", padding: "2px 8px", borderRadius: "4px" }, children: a }),
              f && /* @__PURE__ */ n("span", { children: [
                "• ",
                f
              ] }),
              x && /* @__PURE__ */ n("span", { children: [
                "• CNIC: ",
                x
              ] })
            ] })
          ] })
        ] }),
        /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "8px" }, children: [
          o && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: o,
              style: {
                padding: "6px 12px",
                borderRadius: "6px",
                border: "1.5px solid #cbd5e1",
                background: "#FFFFFF",
                color: "#334155",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                gap: "4px"
              },
              children: [
                /* @__PURE__ */ e(ne, { size: 13 }),
                " Copy Link"
              ]
            }
          ),
          i && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: i,
              style: {
                padding: "6px 12px",
                borderRadius: "6px",
                border: "1.5px solid #cbd5e1",
                background: "#f1f5f9",
                color: "#334155",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                gap: "4px"
              },
              children: [
                /* @__PURE__ */ e(ie, { size: 13 }),
                " Edit"
              ]
            }
          ),
          t && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: t,
              style: {
                padding: "6px 12px",
                borderRadius: "6px",
                border: "none",
                background: "#9f1239",
                color: "#FFFFFF",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                display: "flex",
                alignItems: "center",
                gap: "4px"
              },
              children: [
                /* @__PURE__ */ e(E, { size: 13 }),
                " Delete"
              ]
            }
          )
        ] })
      ]
    }
  );
}, De = ({
  columns: r = [],
  data: i = [],
  keyField: t = "id",
  onSort: o,
  emptyMessage: l = "No records found",
  className: d = "",
  style: c
}) => {
  const [s, a] = v(null), [f, x] = v("asc"), p = (g) => {
    if (!g.sortable && g.sortable !== void 0) return;
    const u = g.field;
    let m = "asc";
    s === u && (m = f === "asc" ? "desc" : "asc"), a(u), x(m), o && o(u, m);
  }, y = [...i].sort((g, u) => {
    if (!s) return 0;
    const m = g[s], F = u[s];
    return m === F ? 0 : m == null ? 1 : F == null ? -1 : typeof m == "string" ? f === "asc" ? m.localeCompare(String(F)) : String(F).localeCompare(m) : f === "asc" ? m - F : F - m;
  });
  return /* @__PURE__ */ e("div", { className: `orion-datagrid-container ${d}`, style: c, children: /* @__PURE__ */ n("table", { className: "orion-datagrid", children: [
    /* @__PURE__ */ e("thead", { children: /* @__PURE__ */ e("tr", { children: r.map((g, u) => {
      const m = s === g.field;
      return /* @__PURE__ */ e(
        "th",
        {
          onClick: () => p(g),
          style: {
            cursor: g.sortable !== !1 ? "pointer" : "default",
            width: g.width,
            minWidth: g.minWidth,
            textAlign: g.align || "left",
            ...g.headerStyle
          },
          title: g.sortable !== !1 ? `Sort by ${g.header}` : void 0,
          children: /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", justifyContent: g.align === "right" ? "flex-end" : "space-between", gap: "4px" }, children: [
            /* @__PURE__ */ e("span", { children: g.header }),
            g.sortable !== !1 && (m ? f === "asc" ? /* @__PURE__ */ e(re, { size: 14, strokeWidth: 2.8 }) : /* @__PURE__ */ e(te, { size: 14, strokeWidth: 2.8 }) : /* @__PURE__ */ e(oe, { size: 13, style: { opacity: 0.35 } }))
          ] })
        },
        u
      );
    }) }) }),
    /* @__PURE__ */ e("tbody", { children: y.length === 0 ? /* @__PURE__ */ e("tr", { children: /* @__PURE__ */ e("td", { colSpan: r.length, style: { textAlign: "center", padding: "2rem", color: "#94a3b8" }, children: l }) }) : y.map((g, u) => /* @__PURE__ */ e("tr", { children: r.map((m, F) => /* @__PURE__ */ e("td", { style: { textAlign: m.align || "left", ...m.cellStyle }, children: m.render ? m.render(g[m.field], g) : g[m.field] }, F)) }, g[t] || u)) })
  ] }) });
}, Ae = ({
  currentPage: r = 1,
  pageSize: i = 10,
  totalItems: t = 0,
  onPageChange: o,
  onPageSizeChange: l,
  pageSizeOptions: d = [10, 20, 30, 50],
  className: c = "",
  style: s
}) => {
  const a = Math.max(1, Math.ceil(t / i)), f = (p) => {
    l && l(p);
  }, x = (p) => {
    o && p >= 1 && p <= a && o(p);
  };
  return /* @__PURE__ */ n(
    "div",
    {
      className: `orion-pagination ${c}`,
      style: {
        display: "flex",
        justifyContent: "space-between",
        alignItems: "center",
        gap: "1rem",
        width: "fit-content",
        padding: "0.4rem 0.85rem",
        background: "#FFFFFF",
        borderRadius: "8px",
        border: "1.5px solid #cbd5e1",
        fontSize: "0.85rem",
        color: "#475569",
        flexShrink: 0,
        ...s
      },
      children: [
        /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.4rem" }, children: [
          /* @__PURE__ */ e(
            "button",
            {
              type: "button",
              onClick: () => x(r - 1),
              disabled: r === 1,
              style: {
                background: "#FFFFFF",
                border: "1.5px solid #cbd5e1",
                borderRadius: "0.375rem",
                padding: "0.25rem 0.65rem",
                fontSize: "0.82rem",
                fontWeight: 600,
                color: r === 1 ? "#94a3b8" : "#0f172a",
                cursor: r === 1 ? "not-allowed" : "pointer"
              },
              children: "Previous"
            }
          ),
          /* @__PURE__ */ e(
            "button",
            {
              type: "button",
              onClick: () => x(1),
              style: {
                background: r === 1 ? "#f1f5f9" : "#FFFFFF",
                border: "1.5px solid #cbd5e1",
                borderRadius: "0.375rem",
                padding: "0.25rem 0.55rem",
                fontSize: "0.82rem",
                fontWeight: 700,
                color: "#0f172a",
                cursor: "pointer"
              },
              children: "1"
            }
          ),
          a > 2 && /* @__PURE__ */ e("span", { style: { color: "#94a3b8" }, children: "..." }),
          a > 1 && /* @__PURE__ */ e(
            "button",
            {
              type: "button",
              onClick: () => x(a),
              style: {
                background: r === a ? "#f1f5f9" : "#FFFFFF",
                border: "1.5px solid #cbd5e1",
                borderRadius: "0.375rem",
                padding: "0.25rem 0.55rem",
                fontSize: "0.82rem",
                fontWeight: 700,
                color: "#0f172a",
                cursor: "pointer"
              },
              children: a
            }
          ),
          /* @__PURE__ */ e(
            "button",
            {
              type: "button",
              onClick: () => x(r + 1),
              disabled: r === a,
              style: {
                background: "#02658b",
                color: "#FFFFFF",
                border: "none",
                borderRadius: "0.375rem",
                padding: "0.25rem 0.75rem",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: r === a ? "not-allowed" : "pointer",
                opacity: r === a ? 0.5 : 1
              },
              children: "Next"
            }
          )
        ] }),
        /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.75rem" }, children: [
          /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.35rem" }, children: [
            /* @__PURE__ */ e("span", { children: "Rows" }),
            /* @__PURE__ */ e(
              "select",
              {
                value: i,
                onChange: (p) => f(Number(p.target.value)),
                style: {
                  background: "#FFFFFF",
                  border: "1.5px solid #cbd5e1",
                  borderRadius: "0.375rem",
                  padding: "0.2rem 0.45rem",
                  fontSize: "0.82rem",
                  color: "#0f172a",
                  cursor: "pointer"
                },
                children: d.map((p) => /* @__PURE__ */ n("option", { value: p, children: [
                  p,
                  " ▾"
                ] }, p))
              }
            )
          ] }),
          /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.35rem" }, children: [
            /* @__PURE__ */ e("span", { children: "Page #" }),
            /* @__PURE__ */ e(
              "select",
              {
                value: r,
                onChange: (p) => x(Number(p.target.value)),
                style: {
                  background: "#FFFFFF",
                  border: "1.5px solid #cbd5e1",
                  borderRadius: "0.375rem",
                  padding: "0.2rem 0.45rem",
                  fontSize: "0.82rem",
                  color: "#0f172a",
                  cursor: "pointer"
                },
                children: Array.from({ length: a }, (p, y) => y + 1).map((p) => /* @__PURE__ */ n("option", { value: p, children: [
                  p < 10 ? `0${p}` : p,
                  " ▾"
                ] }, p))
              }
            )
          ] })
        ] })
      ]
    }
  );
}, je = ({
  isOpen: r,
  title: i = "Confirm Action",
  subtitle: t = "Permanent Action",
  message: o,
  confirmText: l = "Confirm",
  cancelText: d = "Cancel",
  confirmVariant: c = "danger",
  loading: s = !1,
  error: a = null,
  onConfirm: f,
  onCancel: x,
  className: p = "",
  style: y
}) => {
  if (!r) return null;
  const g = c === "danger", u = g ? "#9f1239" : "#02658b", m = g ? "#ffe4e6" : "#e5f3f7", F = g ? "#9f1239" : "#02658b", z = /* @__PURE__ */ e(
    "div",
    {
      className: `orion-modal-overlay confirm-modal-portal ${p}`,
      style: {
        position: "fixed",
        inset: 0,
        backgroundColor: "rgba(15, 23, 42, 0.5)",
        backdropFilter: "blur(4px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 1e4,
        padding: "1rem",
        ...y
      },
      onClick: x,
      children: /* @__PURE__ */ n(
        "div",
        {
          className: "orion-modal-box",
          style: {
            background: "#FFFFFF",
            borderRadius: "0.75rem",
            border: "1.5px solid #cbd5e1",
            width: "100%",
            maxWidth: "420px",
            padding: "1.5rem",
            display: "flex",
            flexDirection: "column",
            gap: "1rem",
            boxShadow: "0 20px 25px -5px rgba(0,0,0,0.15)"
          },
          onClick: (w) => w.stopPropagation(),
          children: [
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "flex-start" }, children: [
              /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.75rem" }, children: [
                /* @__PURE__ */ e(
                  "div",
                  {
                    style: {
                      width: "40px",
                      height: "40px",
                      borderRadius: "50%",
                      background: m,
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center",
                      color: u,
                      flexShrink: 0
                    },
                    children: /* @__PURE__ */ e(B, { size: 22 })
                  }
                ),
                /* @__PURE__ */ n("div", { children: [
                  /* @__PURE__ */ e("h3", { style: { margin: 0, fontSize: "1.1rem", fontWeight: 700, color: "#0f172a" }, children: i }),
                  t && /* @__PURE__ */ e("p", { style: { margin: "0.15rem 0 0 0", fontSize: "0.8rem", color: "#64748b" }, children: t })
                ] })
              ] }),
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: x,
                  disabled: s,
                  style: { background: "none", border: "none", color: "#64748b", cursor: "pointer" },
                  children: /* @__PURE__ */ e(C, { size: 18 })
                }
              )
            ] }),
            a && /* @__PURE__ */ e("div", { style: { background: "#ffe4e6", border: "1px solid #fecdd3", color: "#9f1239", padding: "0.65rem", borderRadius: "0.375rem", fontSize: "0.82rem" }, children: a }),
            /* @__PURE__ */ e("div", { style: { fontSize: "0.9rem", color: "#334155", lineHeight: 1.5 }, children: o }),
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "flex-end", gap: "0.65rem", marginTop: "0.5rem" }, children: [
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: x,
                  disabled: s,
                  style: {
                    background: "#f1f5f9",
                    border: "1.5px solid #cbd5e1",
                    color: "#475569",
                    padding: "0.5rem 1rem",
                    borderRadius: "0.375rem",
                    cursor: "pointer",
                    fontWeight: 600,
                    fontSize: "0.85rem"
                  },
                  children: d
                }
              ),
              /* @__PURE__ */ n(
                "button",
                {
                  type: "button",
                  onClick: f,
                  disabled: s,
                  style: {
                    background: F,
                    border: "none",
                    color: "#FFFFFF",
                    padding: "0.5rem 1.15rem",
                    borderRadius: "0.375rem",
                    cursor: "pointer",
                    fontWeight: 600,
                    fontSize: "0.85rem",
                    display: "flex",
                    alignItems: "center",
                    gap: "0.4rem"
                  },
                  children: [
                    g && /* @__PURE__ */ e(E, { size: 16 }),
                    /* @__PURE__ */ e("span", { children: s ? "Processing..." : l })
                  ]
                }
              )
            ] })
          ]
        }
      )
    }
  );
  return typeof document < "u" ? I(z, document.body) : z;
}, Pe = ({
  isOpen: r,
  title: i = "Notification",
  description: t,
  variant: o = "info",
  confirmText: l = "Got it",
  onClose: d,
  className: c = "",
  style: s
}) => {
  if (!r) return null;
  const a = {
    success: /* @__PURE__ */ e(T, { size: 24, color: "#10b981" }),
    danger: /* @__PURE__ */ e(N, { size: 24, color: "#ef4444" }),
    warning: /* @__PURE__ */ e(B, { size: 24, color: "#f59e0b" }),
    info: /* @__PURE__ */ e(le, { size: 24, color: "#02658b" })
  }, f = /* @__PURE__ */ e(
    "div",
    {
      className: `orion-modal-overlay alert-dialog-portal ${c}`,
      style: {
        position: "fixed",
        inset: 0,
        backgroundColor: "rgba(15, 23, 42, 0.5)",
        backdropFilter: "blur(4px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 1e4,
        padding: "1rem",
        ...s
      },
      onClick: d,
      children: /* @__PURE__ */ n(
        "div",
        {
          className: "orion-modal-box",
          style: {
            background: "#FFFFFF",
            borderRadius: "0.75rem",
            border: "1.5px solid #cbd5e1",
            width: "100%",
            maxWidth: "420px",
            padding: "1.5rem",
            display: "flex",
            flexDirection: "column",
            gap: "1rem",
            boxShadow: "0 20px 25px -5px rgba(0,0,0,0.15)"
          },
          onClick: (x) => x.stopPropagation(),
          children: [
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "flex-start" }, children: [
              /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "0.75rem" }, children: [
                a[o] || a.info,
                /* @__PURE__ */ e("h3", { style: { margin: 0, fontSize: "1.1rem", fontWeight: 700, color: "#0f172a" }, children: i })
              ] }),
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: d,
                  style: { background: "none", border: "none", color: "#64748b", cursor: "pointer" },
                  children: /* @__PURE__ */ e(C, { size: 18 })
                }
              )
            ] }),
            /* @__PURE__ */ e("div", { style: { fontSize: "0.9rem", color: "#334155", lineHeight: 1.5 }, children: t }),
            /* @__PURE__ */ e("div", { style: { display: "flex", justifyContent: "flex-end", marginTop: "0.5rem" }, children: /* @__PURE__ */ e(
              "button",
              {
                type: "button",
                onClick: d,
                style: {
                  background: "#02658b",
                  border: "none",
                  color: "#FFFFFF",
                  padding: "0.5rem 1.25rem",
                  borderRadius: "0.375rem",
                  cursor: "pointer",
                  fontWeight: 600,
                  fontSize: "0.85rem"
                },
                children: l
              }
            ) })
          ]
        }
      )
    }
  );
  return typeof document < "u" ? I(f, document.body) : f;
}, ue = ({
  size: r = 20,
  text: i,
  fullPage: t = !1,
  color: o = "#02658b",
  className: l = "",
  style: d
}) => {
  const c = /* @__PURE__ */ n(
    "div",
    {
      style: {
        display: "inline-flex",
        alignItems: "center",
        gap: "10px",
        ...d
      },
      className: l,
      children: [
        /* @__PURE__ */ e(
          "div",
          {
            style: {
              width: r,
              height: r,
              border: "2.5px solid #e2e8f0",
              borderTopColor: o,
              borderRadius: "50%",
              animation: "spin 0.75s linear infinite",
              flexShrink: 0
            }
          }
        ),
        i && /* @__PURE__ */ e("span", { style: { fontSize: "0.85rem", color: "#475569", fontWeight: 600 }, children: i })
      ]
    }
  );
  return t ? /* @__PURE__ */ e(
    "div",
    {
      style: {
        position: "fixed",
        inset: 0,
        background: "rgba(255, 255, 255, 0.85)",
        backdropFilter: "blur(3px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 9999
      },
      children: c
    }
  ) : c;
}, k = K.forwardRef(({
  children: r,
  variant: i = "primary",
  // 'primary' | 'secondary' | 'danger' | 'outline' | 'ghost'
  size: t = "md",
  // 'sm' | 'md' | 'lg'
  isLoading: o = !1,
  disabled: l = !1,
  iconLeft: d,
  iconRight: c,
  className: s = "",
  style: a,
  ...f
}, x) => {
  const p = `orion-btn-${i}`, y = `orion-btn-${t}`;
  return /* @__PURE__ */ n(
    "button",
    {
      ref: x,
      disabled: l || o,
      className: `orion-btn ${p} ${y} ${s}`,
      style: a,
      ...f,
      children: [
        o ? /* @__PURE__ */ e(ue, { size: t === "lg" ? 18 : t === "sm" ? 12 : 14, color: i === "primary" || i === "danger" ? "#ffffff" : "#02658b" }) : d ? /* @__PURE__ */ e("span", { className: "orion-btn-icon-left", style: { display: "inline-flex" }, children: d }) : null,
        /* @__PURE__ */ e("span", { children: r }),
        !o && c && /* @__PURE__ */ e("span", { className: "orion-btn-icon-right", style: { display: "inline-flex" }, children: c })
      ]
    }
  );
});
k.displayName = "Button";
const Ee = ({
  label: r = "Filter",
  count: i,
  active: t = !1,
  onClick: o,
  className: l = "",
  style: d
}) => /* @__PURE__ */ n(
  "button",
  {
    type: "button",
    onClick: o,
    className: `orion-filter-btn ${t ? "active" : ""} ${l}`,
    style: {
      display: "inline-flex",
      alignItems: "center",
      gap: "6px",
      padding: "0.35rem 0.85rem",
      borderRadius: "50px",
      border: t ? "1.5px solid #02658b" : "1.5px solid #cbd5e1",
      background: t ? "#e5f3f7" : "#FFFFFF",
      color: t ? "#02658b" : "#475569",
      fontSize: "0.82rem",
      fontWeight: 600,
      cursor: "pointer",
      transition: "all 0.15s ease",
      boxShadow: t ? "0 1px 3px rgba(2,101,139,0.1)" : "none",
      ...d
    },
    children: [
      /* @__PURE__ */ e(de, { size: 14, color: t ? "#02658b" : "#64748b" }),
      /* @__PURE__ */ e("span", { children: r }),
      i !== void 0 && /* @__PURE__ */ e(
        "span",
        {
          style: {
            background: t ? "#02658b" : "#cbd5e1",
            color: "#FFFFFF",
            padding: "1px 6px",
            borderRadius: "9999px",
            fontSize: "0.72rem",
            fontWeight: 700
          },
          children: i
        }
      )
    ]
  }
), Be = ({
  value: r = "",
  onChange: i,
  onClear: t,
  placeholder: o = "Search by name, role, email, phone or CNIC...",
  showFilterToggle: l = !1,
  onFilterToggle: d,
  filterActive: c = !1,
  className: s = "",
  style: a
}) => /* @__PURE__ */ n(
  "div",
  {
    className: `orion-search-bar ${s}`,
    style: {
      position: "relative",
      display: "flex",
      alignItems: "center",
      width: "100%",
      ...a
    },
    children: [
      /* @__PURE__ */ e(
        se,
        {
          size: 16,
          color: "#64748b",
          style: {
            position: "absolute",
            left: "12px",
            pointerEvents: "none"
          }
        }
      ),
      /* @__PURE__ */ e(
        "input",
        {
          type: "text",
          value: r,
          onChange: (f) => i && i(f.target.value),
          placeholder: o,
          style: {
            width: "100%",
            height: "38px",
            borderRadius: "8px",
            border: "1.5px solid #cbd5e1",
            padding: l ? "0 68px 0 36px" : "0 36px 0 36px",
            fontSize: "0.85rem",
            color: "#0f172a",
            outline: "none",
            background: "#FFFFFF",
            transition: "border-color 0.15s ease",
            boxSizing: "border-box"
          }
        }
      ),
      /* @__PURE__ */ n("div", { style: { position: "absolute", right: "8px", display: "flex", alignItems: "center", gap: "4px" }, children: [
        r && /* @__PURE__ */ e(
          "button",
          {
            type: "button",
            onClick: () => {
              t ? t() : i && i("");
            },
            style: {
              background: "none",
              border: "none",
              color: "#94a3b8",
              cursor: "pointer",
              padding: "4px",
              display: "flex",
              alignItems: "center"
            },
            title: "Clear search",
            children: /* @__PURE__ */ e(C, { size: 14 })
          }
        ),
        l && /* @__PURE__ */ e(
          "button",
          {
            type: "button",
            onClick: d,
            style: {
              background: c ? "#e5f3f7" : "none",
              border: c ? "1px solid #bfdbfe" : "none",
              color: c ? "#02658b" : "#64748b",
              borderRadius: "4px",
              padding: "4px 6px",
              cursor: "pointer",
              display: "flex",
              alignItems: "center"
            },
            title: "Toggle filters",
            children: /* @__PURE__ */ e(ae, { size: 15 })
          }
        )
      ] })
    ]
  }
), Te = ({
  label: r = "Phone Number",
  value: i = "",
  onChange: t,
  placeholder: o = "123 045 223 48",
  error: l,
  maxLength: d = 14,
  required: c = !1,
  className: s = "",
  style: a
}) => {
  const f = (x) => {
    const p = x.target.value.replace(/[^\d+ ]/g, "");
    t && t(p.slice(0, d));
  };
  return /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px", width: "100%", ...a }, className: s, children: [
    r && /* @__PURE__ */ n("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: [
      r,
      " ",
      c && /* @__PURE__ */ e("span", { style: { color: "#ef4444" }, children: "*" })
    ] }),
    /* @__PURE__ */ n("div", { style: { position: "relative", display: "flex", alignItems: "center", width: "100%" }, children: [
      /* @__PURE__ */ e(ce, { size: 14, color: "#94a3b8", style: { position: "absolute", left: "12px", pointerEvents: "none" } }),
      /* @__PURE__ */ e(
        "input",
        {
          type: "tel",
          value: i,
          onChange: f,
          placeholder: o,
          style: {
            width: "100%",
            height: "38px",
            borderRadius: "8px",
            border: l ? "1.5px solid #ef4444" : "1.5px solid #cbd5e1",
            padding: "0 12px 0 34px",
            fontSize: "0.85rem",
            color: "#0f172a",
            outline: "none",
            background: "#FFFFFF",
            boxSizing: "border-box"
          }
        }
      )
    ] }),
    l && /* @__PURE__ */ e("span", { style: { color: "#ef4444", fontSize: "0.75rem", fontWeight: 600 }, children: l })
  ] });
}, Le = ({
  label: r,
  options: i = [],
  value: t,
  onChange: o,
  error: l,
  placeholder: d = "Select an option",
  required: c = !1,
  className: s = "",
  style: a
}) => /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px", width: "100%", ...a }, className: s, children: [
  r && /* @__PURE__ */ n("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: [
    r,
    " ",
    c && /* @__PURE__ */ e("span", { style: { color: "#ef4444" }, children: "*" })
  ] }),
  /* @__PURE__ */ n(
    "select",
    {
      value: t,
      onChange: (f) => o && o(f.target.value),
      style: {
        width: "100%",
        height: "38px",
        borderRadius: "8px",
        border: l ? "1.5px solid #ef4444" : "1.5px solid #cbd5e1",
        padding: "0 10px",
        fontSize: "0.85rem",
        color: "#0f172a",
        outline: "none",
        background: "#FFFFFF",
        cursor: "pointer",
        boxSizing: "border-box"
      },
      children: [
        d && /* @__PURE__ */ e("option", { value: "", children: d }),
        i.map((f, x) => {
          const p = typeof f == "object" ? f.value : f, y = typeof f == "object" ? f.label : f;
          return /* @__PURE__ */ e("option", { value: p, children: y }, x);
        })
      ]
    }
  ),
  l && /* @__PURE__ */ e("span", { style: { color: "#ef4444", fontSize: "0.75rem", fontWeight: 600 }, children: l })
] }), Ue = ({
  onSubmit: r,
  loading: i = !1,
  error: t = null,
  title: o = "Sign In to Your Account",
  subtitle: l = "Enter your credentials to continue",
  className: d = "",
  style: c
}) => {
  const [s, a] = v(""), [f, x] = v(""), [p, y] = v(!1), g = (u) => {
    u.preventDefault(), r && r({ username: s, password: f });
  };
  return /* @__PURE__ */ n(
    "div",
    {
      className: `orion-login-form-card ${d}`,
      style: {
        background: "#FFFFFF",
        border: "1.5px solid #cbd5e1",
        borderRadius: "12px",
        padding: "2rem",
        maxWidth: "400px",
        width: "100%",
        boxShadow: "0 4px 6px -1px rgba(0, 0, 0, 0.05)",
        boxSizing: "border-box",
        ...c
      },
      children: [
        /* @__PURE__ */ n("div", { style: { textAlign: "center", marginBottom: "1.5rem" }, children: [
          /* @__PURE__ */ e("h2", { style: { fontSize: "1.4rem", fontWeight: 800, color: "#0f172a", margin: "0 0 0.4rem 0" }, children: o }),
          /* @__PURE__ */ e("p", { style: { fontSize: "0.85rem", color: "#64748b", margin: 0 }, children: l })
        ] }),
        t && /* @__PURE__ */ n(
          "div",
          {
            style: {
              display: "flex",
              alignItems: "center",
              gap: "8px",
              background: "#fef2f2",
              border: "1px solid #fecaca",
              color: "#dc2626",
              padding: "0.65rem 0.85rem",
              borderRadius: "6px",
              fontSize: "0.82rem",
              marginBottom: "1rem"
            },
            children: [
              /* @__PURE__ */ e(N, { size: 16 }),
              /* @__PURE__ */ e("span", { children: t })
            ]
          }
        ),
        /* @__PURE__ */ n("form", { onSubmit: g, style: { display: "flex", flexDirection: "column", gap: "1rem" }, children: [
          /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
            /* @__PURE__ */ e("label", { style: { fontSize: "0.8rem", fontWeight: 700, color: "#334155" }, children: "Username or Email" }),
            /* @__PURE__ */ n("div", { style: { position: "relative", display: "flex", alignItems: "center" }, children: [
              /* @__PURE__ */ e($, { size: 15, color: "#94a3b8", style: { position: "absolute", left: "12px" } }),
              /* @__PURE__ */ e(
                "input",
                {
                  type: "text",
                  placeholder: "Enter your username",
                  value: s,
                  onChange: (u) => a(u.target.value),
                  required: !0,
                  style: {
                    width: "100%",
                    height: "40px",
                    borderRadius: "8px",
                    border: "1.5px solid #cbd5e1",
                    padding: "0 12px 0 36px",
                    fontSize: "0.88rem",
                    color: "#0f172a",
                    outline: "none",
                    boxSizing: "border-box"
                  }
                }
              )
            ] })
          ] }),
          /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
            /* @__PURE__ */ e("label", { style: { fontSize: "0.8rem", fontWeight: 700, color: "#334155" }, children: "Password" }),
            /* @__PURE__ */ n("div", { style: { position: "relative", display: "flex", alignItems: "center" }, children: [
              /* @__PURE__ */ e(L, { size: 15, color: "#94a3b8", style: { position: "absolute", left: "12px" } }),
              /* @__PURE__ */ e(
                "input",
                {
                  type: p ? "text" : "password",
                  placeholder: "Enter your password",
                  value: f,
                  onChange: (u) => x(u.target.value),
                  required: !0,
                  style: {
                    width: "100%",
                    height: "40px",
                    borderRadius: "8px",
                    border: "1.5px solid #cbd5e1",
                    padding: "0 36px 0 36px",
                    fontSize: "0.88rem",
                    color: "#0f172a",
                    outline: "none",
                    boxSizing: "border-box"
                  }
                }
              ),
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: () => y(!p),
                  style: {
                    position: "absolute",
                    right: "10px",
                    background: "none",
                    border: "none",
                    color: "#94a3b8",
                    cursor: "pointer",
                    display: "flex"
                  },
                  children: p ? /* @__PURE__ */ e(U, { size: 16 }) : /* @__PURE__ */ e(M, { size: 16 })
                }
              )
            ] })
          ] }),
          /* @__PURE__ */ e(
            k,
            {
              type: "submit",
              variant: "primary",
              size: "lg",
              isLoading: i,
              iconRight: /* @__PURE__ */ e(pe, { size: 16 }),
              style: { width: "100%", marginTop: "0.5rem" },
              children: "Sign In"
            }
          )
        ] })
      ]
    }
  );
}, Me = ({
  isOpen: r,
  mode: i = "add",
  // 'add' | 'edit'
  initialData: t = null,
  roles: o = ["Teacher", "Student", "Parent"],
  onClose: l,
  onSubmit: d,
  loading: c = !1,
  error: s = null,
  className: a = "",
  style: f
}) => {
  const [x, p] = v("Teacher"), [y, g] = v(""), [u, m] = v(""), [F, z] = v(""), [w, R] = v(""), [D, A] = v(""), [W, q] = v(!1);
  if (P(() => {
    t ? (g(t.name || t.fullName || ""), m(t.cnic || ""), z(t.contact || t.phoneNumber || ""), R(t.email || ""), p(t.role || "Teacher")) : (g(""), m(""), z(""), R(""), A(""), p("Teacher"));
  }, [t, r]), !r) return null;
  const G = (h) => {
    const b = h.target.value.replace(/[^\d]/g, "");
    let S = b;
    b.length > 5 && b.length <= 12 ? S = `${b.slice(0, 5)}-${b.slice(5)}` : b.length > 12 && (S = `${b.slice(0, 5)}-${b.slice(5, 12)}-${b.slice(12, 13)}`), m(S);
  }, _ = (h) => {
    const b = h.target.value.replace(/[^\d]/g, "");
    let S = b;
    b.length > 3 && b.length <= 6 ? S = `${b.slice(0, 3)} ${b.slice(3)}` : b.length > 6 && b.length <= 9 ? S = `${b.slice(0, 3)} ${b.slice(3, 6)} ${b.slice(6)}` : b.length > 9 && (S = `${b.slice(0, 3)} ${b.slice(3, 6)} ${b.slice(6, 9)} ${b.slice(9, 11)}`), z(S);
  }, Y = (h) => {
    h.preventDefault(), d && d({
      role: x,
      fullName: y,
      cnic: u,
      contact: F,
      email: w,
      password: D || void 0
    });
  }, X = (h) => h === "Teacher" ? /* @__PURE__ */ e(ge, { size: 15 }) : h === "Parent" ? /* @__PURE__ */ e(xe, { size: 15 }) : /* @__PURE__ */ e($, { size: 15 }), j = /* @__PURE__ */ e(
    "div",
    {
      className: `orion-modal-overlay user-dialog-portal ${a}`,
      style: {
        position: "fixed",
        inset: 0,
        backgroundColor: "rgba(15, 23, 42, 0.5)",
        backdropFilter: "blur(4px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 1e4,
        padding: "1rem",
        ...f
      },
      onClick: l,
      children: /* @__PURE__ */ n(
        "div",
        {
          className: "orion-modal-box",
          style: {
            background: "#FFFFFF",
            borderRadius: "12px",
            border: "1.5px solid #cbd5e1",
            width: "100%",
            maxWidth: "560px",
            padding: "1.5rem",
            display: "flex",
            flexDirection: "column",
            gap: "1rem",
            boxShadow: "0 20px 25px -5px rgba(0,0,0,0.15)",
            maxHeight: "90vh",
            overflowY: "auto"
          },
          onClick: (h) => h.stopPropagation(),
          children: [
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "center", borderBottom: "1px solid #f1f5f9", paddingBottom: "0.75rem" }, children: [
              /* @__PURE__ */ n("div", { children: [
                /* @__PURE__ */ e("h3", { style: { margin: 0, fontSize: "1.15rem", fontWeight: 800, color: "#0f172a" }, children: i === "add" ? "Add New User" : "Edit User Details" }),
                /* @__PURE__ */ e("p", { style: { margin: "2px 0 0 0", fontSize: "0.8rem", color: "#64748b" }, children: i === "add" ? "Create an account and assign workspace role." : "Update user profile and contact information." })
              ] }),
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: l,
                  style: { background: "none", border: "none", color: "#94a3b8", cursor: "pointer" },
                  children: /* @__PURE__ */ e(C, { size: 18 })
                }
              )
            ] }),
            /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "6px", alignItems: "center" }, children: [
              /* @__PURE__ */ e("span", { style: { fontSize: "0.85rem", fontWeight: 700, color: "#0f172a" }, children: "Select Role" }),
              /* @__PURE__ */ e(
                "div",
                {
                  style: {
                    display: "flex",
                    alignItems: "center",
                    gap: "6px",
                    background: "#FFFFFF",
                    padding: "4px",
                    borderRadius: "50px",
                    border: "1.5px solid #cbd5e1"
                  },
                  children: o.map((h) => {
                    const b = x === h;
                    return /* @__PURE__ */ n(
                      "button",
                      {
                        type: "button",
                        onClick: () => p(h),
                        style: {
                          display: "flex",
                          alignItems: "center",
                          gap: "4px",
                          padding: "5px 14px",
                          borderRadius: "50px",
                          fontSize: "0.82rem",
                          fontWeight: 700,
                          cursor: "pointer",
                          border: b ? "1.5px solid #02658b" : "1.5px solid transparent",
                          background: b ? "#FFFFFF" : "transparent",
                          color: b ? "#02658b" : "#64748b",
                          boxShadow: b ? "0 1px 4px rgba(2,101,139,0.15)" : "none",
                          transition: "all 0.15s ease"
                        },
                        children: [
                          X(h),
                          /* @__PURE__ */ e("span", { children: h })
                        ]
                      },
                      h
                    );
                  })
                }
              )
            ] }),
            s && /* @__PURE__ */ n(
              "div",
              {
                style: {
                  display: "flex",
                  alignItems: "center",
                  gap: "6px",
                  background: "#fef2f2",
                  border: "1px solid #fecaca",
                  color: "#dc2626",
                  padding: "8px 12px",
                  borderRadius: "6px",
                  fontSize: "0.82rem"
                },
                children: [
                  /* @__PURE__ */ e(N, { size: 15 }),
                  /* @__PURE__ */ e("span", { children: s })
                ]
              }
            ),
            /* @__PURE__ */ n("form", { onSubmit: Y, style: { display: "flex", flexDirection: "column", gap: "1rem" }, children: [
              /* @__PURE__ */ n("div", { style: { display: "grid", gridTemplateColumns: "1fr 1fr", gap: "0.85rem" }, children: [
                /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
                  /* @__PURE__ */ n("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: [
                    "Full Name ",
                    /* @__PURE__ */ e("span", { style: { color: "#ef4444" }, children: "*" })
                  ] }),
                  /* @__PURE__ */ e(
                    "input",
                    {
                      type: "text",
                      placeholder: "Enter name here",
                      value: y,
                      onChange: (h) => g(h.target.value),
                      required: !0,
                      style: {
                        height: "38px",
                        borderRadius: "8px",
                        border: "1.5px solid #cbd5e1",
                        padding: "0 10px",
                        fontSize: "0.85rem",
                        outline: "none"
                      }
                    }
                  )
                ] }),
                /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
                  /* @__PURE__ */ e("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: "CNIC (13 Digits)" }),
                  /* @__PURE__ */ e(
                    "input",
                    {
                      type: "text",
                      placeholder: "1234-5678910-2",
                      value: u,
                      onChange: G,
                      maxLength: 15,
                      style: {
                        height: "38px",
                        borderRadius: "8px",
                        border: "1.5px solid #cbd5e1",
                        padding: "0 10px",
                        fontSize: "0.85rem",
                        outline: "none"
                      }
                    }
                  )
                ] }),
                /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
                  /* @__PURE__ */ e("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: "Contact Number" }),
                  /* @__PURE__ */ e(
                    "input",
                    {
                      type: "text",
                      placeholder: "123 045 223 48",
                      value: F,
                      onChange: _,
                      maxLength: 14,
                      style: {
                        height: "38px",
                        borderRadius: "8px",
                        border: "1.5px solid #cbd5e1",
                        padding: "0 10px",
                        fontSize: "0.85rem",
                        outline: "none"
                      }
                    }
                  )
                ] }),
                /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
                  /* @__PURE__ */ n("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: [
                    "Email Address ",
                    /* @__PURE__ */ e("span", { style: { color: "#ef4444" }, children: "*" })
                  ] }),
                  /* @__PURE__ */ e(
                    "input",
                    {
                      type: "email",
                      placeholder: "Enter email address",
                      value: w,
                      onChange: (h) => R(h.target.value),
                      required: !0,
                      style: {
                        height: "38px",
                        borderRadius: "8px",
                        border: "1.5px solid #cbd5e1",
                        padding: "0 10px",
                        fontSize: "0.85rem",
                        outline: "none"
                      }
                    }
                  )
                ] })
              ] }),
              i === "add" && /* @__PURE__ */ n("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: [
                /* @__PURE__ */ n("label", { style: { fontSize: "0.78rem", fontWeight: 700, color: "#334155" }, children: [
                  "Temporary Password ",
                  /* @__PURE__ */ e("span", { style: { color: "#ef4444" }, children: "*" })
                ] }),
                /* @__PURE__ */ n("div", { style: { position: "relative", display: "flex", alignItems: "center" }, children: [
                  /* @__PURE__ */ e(L, { size: 15, color: "#94a3b8", style: { position: "absolute", left: "10px" } }),
                  /* @__PURE__ */ e(
                    "input",
                    {
                      type: W ? "text" : "password",
                      placeholder: "Enter temporary password",
                      value: D,
                      onChange: (h) => A(h.target.value),
                      required: !0,
                      style: {
                        width: "100%",
                        height: "38px",
                        borderRadius: "8px",
                        border: "1.5px solid #cbd5e1",
                        padding: "0 36px 0 32px",
                        fontSize: "0.85rem",
                        outline: "none",
                        boxSizing: "border-box"
                      }
                    }
                  ),
                  /* @__PURE__ */ e(
                    "button",
                    {
                      type: "button",
                      onClick: () => q(!W),
                      style: { position: "absolute", right: "10px", background: "none", border: "none", color: "#94a3b8", cursor: "pointer", display: "flex" },
                      children: W ? /* @__PURE__ */ e(U, { size: 15 }) : /* @__PURE__ */ e(M, { size: 15 })
                    }
                  )
                ] })
              ] }),
              /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "flex-end", gap: "8px", borderTop: "1px solid #f1f5f9", paddingTop: "1rem", marginTop: "0.5rem" }, children: [
                /* @__PURE__ */ e(k, { variant: "secondary", type: "button", onClick: l, disabled: c, children: "Cancel" }),
                /* @__PURE__ */ e(k, { variant: "primary", type: "submit", isLoading: c, iconLeft: /* @__PURE__ */ e(fe, { size: 15 }), children: i === "add" ? "Save & Create" : "Save Changes" })
              ] })
            ] })
          ]
        }
      )
    }
  );
  return typeof document < "u" ? I(j, document.body) : j;
}, ye = ({
  isOpen: r,
  currentVersion: i = "v2.4.0",
  latestVersion: t = "v2.4.1",
  hasUpdate: o = !1,
  releaseNotes: l = ["Optimized User & Role Management DataGrid", "Improved modal form validation and phone number limits", "Enhanced system stability and faster synchronization"],
  onClose: d,
  onUpdateDownload: c,
  updating: s = !1,
  className: a = "",
  style: f
}) => {
  if (!r) return null;
  const x = /* @__PURE__ */ e(
    "div",
    {
      className: `orion-modal-overlay update-dialog-portal ${a}`,
      style: {
        position: "fixed",
        inset: 0,
        backgroundColor: "rgba(15, 23, 42, 0.5)",
        backdropFilter: "blur(4px)",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        zIndex: 1e4,
        padding: "1rem",
        ...f
      },
      onClick: d,
      children: /* @__PURE__ */ n(
        "div",
        {
          className: "orion-modal-box",
          style: {
            background: "#FFFFFF",
            borderRadius: "12px",
            border: "1.5px solid #cbd5e1",
            width: "100%",
            maxWidth: "460px",
            padding: "1.5rem",
            display: "flex",
            flexDirection: "column",
            gap: "1rem",
            boxShadow: "0 20px 25px -5px rgba(0,0,0,0.15)"
          },
          onClick: (p) => p.stopPropagation(),
          children: [
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "center" }, children: [
              /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "8px" }, children: [
                /* @__PURE__ */ e(
                  "div",
                  {
                    style: {
                      width: "36px",
                      height: "36px",
                      borderRadius: "50%",
                      background: o ? "#fef3c7" : "#e5f3f7",
                      color: o ? "#b45309" : "#02658b",
                      display: "flex",
                      alignItems: "center",
                      justifyContent: "center"
                    },
                    children: o ? /* @__PURE__ */ e(O, { size: 20 }) : /* @__PURE__ */ e(T, { size: 20 })
                  }
                ),
                /* @__PURE__ */ n("div", { children: [
                  /* @__PURE__ */ e("h3", { style: { margin: 0, fontSize: "1.1rem", fontWeight: 800, color: "#0f172a" }, children: o ? "System Update Available" : "System Up to Date" }),
                  /* @__PURE__ */ n("div", { style: { fontSize: "0.78rem", color: "#64748b" }, children: [
                    "Installed: ",
                    /* @__PURE__ */ e("strong", { children: i }),
                    " ",
                    o && `→ Latest: ${t}`
                  ] })
                ] })
              ] }),
              /* @__PURE__ */ e(
                "button",
                {
                  type: "button",
                  onClick: d,
                  style: { background: "none", border: "none", color: "#94a3b8", cursor: "pointer" },
                  children: /* @__PURE__ */ e(C, { size: 18 })
                }
              )
            ] }),
            o ? /* @__PURE__ */ n("div", { children: [
              /* @__PURE__ */ n("div", { style: { fontSize: "0.85rem", fontWeight: 700, color: "#334155", marginBottom: "6px" }, children: [
                "What's New in ",
                t,
                ":"
              ] }),
              /* @__PURE__ */ e("ul", { style: { margin: 0, paddingLeft: "1.2rem", fontSize: "0.82rem", color: "#475569", lineHeight: 1.6 }, children: l.map((p, y) => /* @__PURE__ */ e("li", { children: p }, y)) })
            ] }) : /* @__PURE__ */ e("p", { style: { margin: 0, fontSize: "0.85rem", color: "#475569", lineHeight: 1.5 }, children: "You are currently running the latest certified build of the Orion application. No pending updates found." }),
            /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "flex-end", gap: "8px", marginTop: "0.5rem", borderTop: "1px solid #f1f5f9", paddingTop: "0.85rem" }, children: [
              /* @__PURE__ */ e(k, { variant: "secondary", onClick: d, children: "Close" }),
              o && /* @__PURE__ */ e(
                k,
                {
                  variant: "primary",
                  onClick: c,
                  isLoading: s,
                  iconLeft: /* @__PURE__ */ e(H, { size: 14 }),
                  children: "Update Now"
                }
              )
            ] })
          ]
        }
      )
    }
  );
  return typeof document < "u" ? I(x, document.body) : x;
}, Fe = ({
  currentVersion: r = "v2.4.0",
  hasUpdate: i = !1,
  latestVersion: t = "v2.4.1",
  releaseNotes: o,
  onUpdateDownload: l,
  className: d = "",
  style: c
}) => {
  const [s, a] = v(!1);
  return /* @__PURE__ */ n(J, { children: [
    /* @__PURE__ */ n(
      "button",
      {
        type: "button",
        onClick: () => a(!0),
        className: `orion-version-badge ${d}`,
        style: {
          display: "inline-flex",
          alignItems: "center",
          gap: "5px",
          fontSize: "0.74rem",
          fontWeight: 700,
          padding: "3px 9px",
          borderRadius: "9999px",
          background: i ? "#fef3c7" : "#e5f3f7",
          color: i ? "#b45309" : "#02658b",
          border: i ? "1.5px solid #fde68a" : "1.5px solid #bfdbfe",
          cursor: "pointer",
          outline: "none",
          ...c
        },
        title: "Click to view update details",
        children: [
          i ? /* @__PURE__ */ e(O, { size: 13 }) : /* @__PURE__ */ e(H, { size: 12 }),
          /* @__PURE__ */ e("span", { children: r }),
          i && /* @__PURE__ */ e("span", { style: { background: "#b45309", color: "#fff", borderRadius: "50%", width: "6px", height: "6px" } })
        ]
      }
    ),
    /* @__PURE__ */ e(
      ye,
      {
        isOpen: s,
        currentVersion: r,
        latestVersion: t,
        hasUpdate: i,
        releaseNotes: o,
        onClose: () => a(!1),
        onUpdateDownload: l
      }
    )
  ] });
}, ve = ({
  user: r = { name: "Super Admin", email: "admin@orion.edu", role: "Super Admin" },
  onLogout: i,
  onSettings: t,
  onProfileClick: o,
  className: l = "",
  style: d
}) => {
  const [c, s] = v(!1), a = Q(null);
  P(() => {
    const x = (p) => {
      a.current && !a.current.contains(p.target) && s(!1);
    };
    return document.addEventListener("mousedown", x), () => document.removeEventListener("mousedown", x);
  }, []);
  const f = r != null && r.name ? r.name.substring(0, 2).toUpperCase() : "U";
  return /* @__PURE__ */ n("div", { className: `orion-profile-dropdown ${l}`, ref: a, style: { position: "relative", ...d }, children: [
    /* @__PURE__ */ n(
      "button",
      {
        type: "button",
        onClick: () => s(!c),
        style: {
          display: "flex",
          alignItems: "center",
          gap: "8px",
          background: "none",
          border: "none",
          cursor: "pointer",
          padding: "4px",
          borderRadius: "8px",
          outline: "none"
        },
        children: [
          /* @__PURE__ */ e(
            "div",
            {
              style: {
                width: "36px",
                height: "36px",
                borderRadius: "50%",
                backgroundColor: "#02658b",
                color: "#FFFFFF",
                display: "flex",
                alignItems: "center",
                justifyContent: "center",
                fontWeight: 800,
                fontSize: "0.85rem",
                flexShrink: 0
              },
              children: f
            }
          ),
          /* @__PURE__ */ n("div", { style: { textAlign: "left", display: "none", sm: "block" }, children: [
            /* @__PURE__ */ e("div", { style: { fontSize: "0.85rem", fontWeight: 700, color: "#0f172a", lineHeight: 1.1 }, children: r == null ? void 0 : r.name }),
            /* @__PURE__ */ e("div", { style: { fontSize: "0.72rem", color: "#64748b" }, children: r == null ? void 0 : r.role })
          ] }),
          /* @__PURE__ */ e(be, { size: 14, color: "#64748b" })
        ]
      }
    ),
    c && /* @__PURE__ */ n(
      "div",
      {
        style: {
          position: "absolute",
          right: 0,
          top: "46px",
          background: "#FFFFFF",
          borderRadius: "8px",
          border: "1.5px solid #cbd5e1",
          boxShadow: "0 10px 15px -3px rgba(0, 0, 0, 0.1)",
          minWidth: "200px",
          padding: "6px",
          zIndex: 1e3,
          display: "flex",
          flexDirection: "column",
          gap: "2px"
        },
        children: [
          /* @__PURE__ */ n("div", { style: { padding: "8px 10px", borderBottom: "1px solid #f1f5f9" }, children: [
            /* @__PURE__ */ e("div", { style: { fontSize: "0.85rem", fontWeight: 700, color: "#0f172a" }, children: r == null ? void 0 : r.name }),
            /* @__PURE__ */ e("div", { style: { fontSize: "0.75rem", color: "#64748b" }, children: r == null ? void 0 : r.email })
          ] }),
          o && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: () => {
                s(!1), o();
              },
              style: {
                display: "flex",
                alignItems: "center",
                gap: "8px",
                width: "100%",
                padding: "8px 10px",
                borderRadius: "6px",
                border: "none",
                background: "none",
                color: "#334155",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                textAlign: "left"
              },
              children: [
                /* @__PURE__ */ e($, { size: 14 }),
                " Profile"
              ]
            }
          ),
          t && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: () => {
                s(!1), t();
              },
              style: {
                display: "flex",
                alignItems: "center",
                gap: "8px",
                width: "100%",
                padding: "8px 10px",
                borderRadius: "6px",
                border: "none",
                background: "none",
                color: "#334155",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                textAlign: "left"
              },
              children: [
                /* @__PURE__ */ e(me, { size: 14 }),
                " Settings"
              ]
            }
          ),
          i && /* @__PURE__ */ n(
            "button",
            {
              type: "button",
              onClick: () => {
                s(!1), i();
              },
              style: {
                display: "flex",
                alignItems: "center",
                gap: "8px",
                width: "100%",
                padding: "8px 10px",
                borderRadius: "6px",
                border: "none",
                background: "none",
                color: "#dc2626",
                fontSize: "0.82rem",
                fontWeight: 600,
                cursor: "pointer",
                textAlign: "left",
                borderTop: "1px solid #f1f5f9"
              },
              children: [
                /* @__PURE__ */ e(he, { size: 14 }),
                " Sign Out"
              ]
            }
          )
        ]
      }
    )
  ] });
}, Oe = ({
  brandName: r = "Orion Academy",
  logo: i,
  user: t = { name: "Super Admin", email: "admin@orion.edu", role: "Super Admin" },
  currentVersion: o = "v2.4.0",
  hasUpdate: l = !1,
  onLogout: d,
  onSettings: c,
  rightActions: s,
  className: a = "",
  style: f
}) => /* @__PURE__ */ n(
  "header",
  {
    className: `orion-navbar ${a}`,
    style: {
      height: "60px",
      background: "#FFFFFF",
      borderBottom: "1.5px solid #cbd5e1",
      display: "flex",
      alignItems: "center",
      justifyContent: "space-between",
      padding: "0 1.5rem",
      position: "sticky",
      top: 0,
      zIndex: 100,
      boxShadow: "0 1px 3px rgba(0,0,0,0.02)",
      ...f
    },
    children: [
      /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "10px" }, children: [
        i && /* @__PURE__ */ e("div", { style: { display: "flex", alignItems: "center" }, children: i }),
        /* @__PURE__ */ e("span", { style: { fontWeight: 800, fontSize: "1.15rem", color: "#02658b", letterSpacing: "-0.01em" }, children: r })
      ] }),
      /* @__PURE__ */ n("div", { style: { display: "flex", alignItems: "center", gap: "12px" }, children: [
        s,
        /* @__PURE__ */ e(Fe, { currentVersion: o, hasUpdate: l }),
        /* @__PURE__ */ e(ve, { user: t, onLogout: d, onSettings: c })
      ] })
    ]
  }
), He = ({
  items: r = [],
  activeItem: i,
  onSelect: t,
  collapsed: o = !1,
  headerTitle: l = "Navigation",
  className: d = "",
  style: c
}) => /* @__PURE__ */ n(
  "aside",
  {
    className: `orion-sidebar ${d}`,
    style: {
      width: o ? "70px" : "240px",
      background: "#FFFFFF",
      borderRight: "1.5px solid #cbd5e1",
      display: "flex",
      flexDirection: "column",
      padding: "1rem 0.75rem",
      transition: "width 0.2s ease",
      height: "100%",
      boxSizing: "border-box",
      ...c
    },
    children: [
      !o && l && /* @__PURE__ */ e(
        "div",
        {
          style: {
            fontSize: "0.72rem",
            fontWeight: 800,
            color: "#94a3b8",
            textTransform: "uppercase",
            marginBottom: "8px",
            paddingLeft: "10px",
            letterSpacing: "0.5px"
          },
          children: l
        }
      ),
      /* @__PURE__ */ e("div", { style: { display: "flex", flexDirection: "column", gap: "4px" }, children: r.map((s) => {
        const a = i === s.key;
        return /* @__PURE__ */ n(
          "button",
          {
            type: "button",
            onClick: () => t && t(s.key, s),
            style: {
              display: "flex",
              alignItems: "center",
              gap: "10px",
              padding: o ? "10px" : "9px 12px",
              borderRadius: "8px",
              border: a ? "1px solid #bfdbfe" : "1px solid transparent",
              background: a ? "#e5f3f7" : "transparent",
              color: a ? "#02658b" : "#475569",
              fontWeight: a ? 700 : 500,
              cursor: "pointer",
              fontSize: "0.86rem",
              textAlign: "left",
              justifyContent: o ? "center" : "flex-start",
              transition: "all 0.15s ease"
            },
            title: o ? s.label : void 0,
            children: [
              s.icon && /* @__PURE__ */ e("span", { style: { display: "flex", color: a ? "#02658b" : "#64748b" }, children: s.icon }),
              !o && /* @__PURE__ */ e("span", { children: s.label })
            ]
          },
          s.key
        );
      }) })
    ]
  }
), qe = ({
  progress: r = 0,
  statusText: i = "Downloading update package...",
  totalSizeText: t,
  className: o = "",
  style: l
}) => {
  const d = Math.min(100, Math.max(0, r));
  return /* @__PURE__ */ n("div", { className: `orion-update-progress ${o}`, style: { width: "100%", display: "flex", flexDirection: "column", gap: "6px", ...l }, children: [
    /* @__PURE__ */ n("div", { style: { display: "flex", justifyContent: "space-between", alignItems: "center", fontSize: "0.8rem", fontWeight: 600, color: "#334155" }, children: [
      /* @__PURE__ */ e("span", { children: i }),
      /* @__PURE__ */ n("span", { children: [
        d,
        "% ",
        t && `(${t})`
      ] })
    ] }),
    /* @__PURE__ */ e("div", { style: { height: "8px", background: "#e2e8f0", borderRadius: "9999px", overflow: "hidden" }, children: /* @__PURE__ */ e(
      "div",
      {
        style: {
          height: "100%",
          width: `${d}%`,
          background: "#02658b",
          borderRadius: "9999px",
          transition: "width 0.25s ease"
        }
      }
    ) })
  ] });
};
export {
  Pe as AlertDialog,
  k as Button,
  je as ConfirmModal,
  Ne as CounterCard,
  ue as CustomLoader,
  De as DataGrid,
  Ee as FilterButton,
  Le as FormSelect,
  Re as GlobalPermissionsBadge,
  Ue as LoginForm,
  Oe as Navbar,
  Ae as Pagination,
  Te as PhoneInput,
  ve as ProfileDropdown,
  Be as SearchBar,
  Ie as SeverityPill,
  He as Sidebar,
  We as StatCard,
  we as StatusPill,
  ye as UpdateDialog,
  qe as UpdateProgressBar,
  $e as UserDetailsCard,
  Me as UserDialogModal,
  Fe as VersionBadge
};
