from flask import Flask,request
from flask_cors import CORS
from report_func import func
from totalizer_func import totalizer_func
from lcc_totalizer_func import lcc_totalizer_func
from current_func import current_func
from ro_func import ro_func
from ro_abs_func import ro_abstract
from ro_summary_func import ro_summary
from ro_detail_func import ro_detail
from ro_nop_func import ro_non_op

app = Flask(__name__)
CORS(app)

@app.route('/ping')
def test():
    return "ping to flask rest api"

@app.route('/specfic-time-report')
def get_report():
    args = request.args
    res = func(args['station0'],args['date'],args['variable'])
    return res

@app.route('/totalizer-report')
def get_totalizer_report():
    args = request.args
    res = totalizer_func(args['station0'],args['date'],args['variable'])
    return res

@app.route('/lcc-totalizer-report')
def get_lcc_totalizer_report():
    args = request.args
    res = lcc_totalizer_func(args['station0'],args['station1'],args['date'],args['variable'])
    return res

@app.route('/current-report')
def get_current_report():
    args = request.args
    res = current_func(args['station0'],args['station1'],args['date'])
    return res

@app.route('/ro-daily')
def get_ro_report():
    args = request.args
    res = ro_func(args['date'])
    return res

@app.route('/ro-abstract')
def get_ro_abstract():
    args = request.args
    res = ro_abstract(args['start_date'],args['end_date'])
    return res

@app.route('/ro-summary')
def get_ro_summary():
    args = request.args
    res = ro_summary(args['start_date'],args['end_date'])
    return res

@app.route('/ro-detail')
def get_ro_detail():
    args = request.args
    res = ro_detail(args['start_date'],args['end_date'])
    return res

@app.route('/ro-non-operational')
def get_ro_non_op():
    args = request.args
    res = ro_non_op(args['date'])
    return res