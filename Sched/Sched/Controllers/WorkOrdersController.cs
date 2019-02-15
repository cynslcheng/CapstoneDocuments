using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Sched.Models;

namespace Sched.Controllers
{
    public class WorkOrdersController : Controller
    {
        private SchedContext db = new SchedContext();

        // GET: WorkOrders
        public async Task<ActionResult> Index(string searchField, string searchValue)
        {
            var workOrder = Session["Filter"] as WorkOrder;
            List<WorkOrder> workOrdersList = null;
            if (workOrder == null)
            {
                workOrdersList = await db.WorkOrder.ToListAsync();
            }
            else if (searchField != null && searchValue != null)
            {
                var query = "SELECT * FROM work_order WHERE " + searchField + " = " + searchValue;
                workOrdersList = await db.WorkOrder.SqlQuery(query).ToListAsync();
            }
            else
            {
                var query = "SELECT * FROM work_order";
                var queryModified = false;
                if (workOrder.Id != 0)
                {
                    if (queryModified)
                    {
                        query += " AND id = " + workOrder.Id;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE id = " + workOrder.Id;
                    }
                }
                if (workOrder.minimum_start_time != Convert.ToDateTime("01/01/0001 12:00:00 AM"))
                {
                    if (queryModified)
                    {
                        query += " AND maximum_start_time > '" + workOrder.minimum_start_time + "'";
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE maximum_start_time > '" + workOrder.minimum_start_time + "'";
                    }
                }
                if (workOrder.maximum_start_time != Convert.ToDateTime("01/01/0001 12:00:00 AM"))
                {
                    if (queryModified)
                    {
                        query += " AND minimum_start_time < '" + workOrder.maximum_start_time + "'";
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE minimum_start_time < '" + workOrder.maximum_start_time + "'";
                    }
                }
                if (workOrder.priority != 0)
                {
                    if (queryModified)
                    {
                        query += " AND priority = " + workOrder.priority;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE priority = " + workOrder.priority;
                    }
                }
                if (workOrder.work_area_id != 0)
                {
                    if (queryModified)
                    {
                        query += " AND work_area_id = " + workOrder.work_area_id;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE work_area_id = " + workOrder.work_area_id;
                    }
                }
                if (workOrder.status_id != 0)
                {
                    if (queryModified)
                    {
                        query += " AND status_id = " + workOrder.status_id;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE status_id = " + workOrder.status_id;
                    }
                }
                if (workOrder.address != null)
                {
                    if (queryModified)
                    {
                        query += " AND address = " + workOrder.address;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE address = " + workOrder.address;
                    }
                }
                if (workOrder.postal_code != null)
                {
                    if (queryModified)
                    {
                        query += " AND postal_code = " + workOrder.postal_code;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE postal_code = " + workOrder.postal_code;
                    }
                }
                if (workOrder.estimated_time_minutes != 0)
                {
                    if (queryModified)
                    {
                        query += " AND estimated_time_minutes = " + workOrder.estimated_time_minutes;
                    }
                    else
                    {
                        queryModified = true;
                        query += " WHERE estimated_time_minutes = " + workOrder.estimated_time_minutes;
                    }
                }
                workOrdersList = await db.WorkOrder.SqlQuery(query).ToListAsync();
            }
            return View(workOrdersList);
        }

        // GET: WorkOrders/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkOrder workOrder = await db.WorkOrder.FindAsync(id);
            if (workOrder == null)
            {
                return HttpNotFound();
            }
            return View(workOrder);
        }

        // GET: WorkOrders/Create
        public ActionResult Filter()
        {
            var workOrder = Session["Filter"] as WorkOrder;
            if (workOrder == null)
            {
                return View();
            }
            return View(workOrder);
        }

        // POST: WorkOrders/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Filter([Bind(Include = "Id,minimum_start_time,maximum_start_time,priority,status_id,work_area_id,estimated_time_minutes,created_at,modified_at")] WorkOrder workOrder)
        {
            Session["Filter"] = workOrder;
            return RedirectToAction("Index");
        }

        // GET: WorkOrders/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkOrder workOrder = await db.WorkOrder.FindAsync(id);
            if (workOrder == null)
            {
                return HttpNotFound();
            }
            return View(workOrder);
        }

        // POST: WorkOrders/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,minimum_start_time,maximum_start_time,priority,status_id,work_area_id,estimated_time_minutes,created_at,modified_at")] WorkOrder workOrder)
        {
            if (ModelState.IsValid)
            {
                db.Entry(workOrder).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(workOrder);
        }

        // GET: WorkOrders/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            WorkOrder workOrder = await db.WorkOrder.FindAsync(id);
            if (workOrder == null)
            {
                return HttpNotFound();
            }
            return View(workOrder);
        }

        // POST: WorkOrders/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            WorkOrder workOrder = await db.WorkOrder.FindAsync(id);
            db.WorkOrder.Remove(workOrder);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
