'use client';

import { useState, useEffect } from 'react';
import { createClient } from '@supabase/supabase-js';
import { Shield, Lock, Mail, ArrowRight, BarChart3, FileText, MessageSquare, Plus, LogOut, Send, Package, Trash2, Award } from 'lucide-react';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';
const supabase = createClient(supabaseUrl, supabaseAnonKey);

export default function LoveworldExpoPortal() {
  const [session, setSession] = useState(null);
  const [userProfile, setUserProfile] = useState(null);
  const [loading, setLoading] = useState(true);

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [authError, setAuthError] = useState('');
  const [authLoading, setAuthLoading] = useState(false);

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session);
      if (session) fetchProfile(session.user.id);
      else setLoading(false);
    });

    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      setSession(session);
      if (session) fetchProfile(session.user.id);
      else {
        setUserProfile(null);
        setLoading(false);
      }
    });

    return () => subscription.unsubscribe();
  }, []);

  const fetchProfile = async (userId) => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
      if (!error && data) {
        setUserProfile(data);
      }
    } catch (e) {
      console.error(e);
    } finally {
      setLoading(false);
    }
  };

  const handleLogin = async (e) => {
    e.preventDefault();
    setAuthLoading(true);
    setAuthError('');
    try {
      const { data, error } = await supabase.auth.signInWithPassword({ email, password });
      if (error) throw error;
      if (data.user) await fetchProfile(data.user.id);
    } catch (err) {
      setAuthError(err.message || 'Invalid credentials. Please try again.');
    } finally {
      setAuthLoading(false);
    }
  };

  const handleLogout = () => {
    supabase.auth.signOut();
  };

  if (loading) {
    return (
      <div className="min-h-screen bg-slate-900 flex items-center justify-center text-white font-sans">
        <div className="flex flex-col items-center space-y-4">
          <div className="w-10 h-10 border-4 border-indigo-500 border-t-transparent rounded-full animate-spin"></div>
          <p className="text-slate-400 text-sm font-medium">Loading Loveworld Expo Portal...</p>
        </div>
      </div>
    );
  }

  if (!session || !userProfile) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-slate-900 px-4 font-sans">
        <div className="max-w-md w-full bg-slate-800 border border-slate-700 rounded-2xl p-8 shadow-2xl">
          <div className="text-center mb-8">
            <div className="inline-flex p-3 bg-indigo-600/20 text-indigo-400 rounded-xl mb-3">
              <Shield className="w-8 h-8" />
            </div>
            <h1 className="text-2xl font-bold text-white">Loveworld Expo Portal</h1>
            <p className="text-slate-400 text-sm mt-1">Sign in with your assigned credentials</p>
          </div>

          {authError && (
            <div className="mb-4 p-3 bg-red-500/10 border border-red-500/30 text-red-400 rounded-xl text-sm">
              {authError}
            </div>
          )}

          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase mb-2">Email</label>
              <div className="relative">
                <Mail className="absolute left-3 top-3.5 text-slate-500 w-5 h-5" />
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="cluster1@loveworldexpo.org"
                  className="w-full pl-10 pr-4 py-3 bg-slate-900 border border-slate-700 rounded-xl text-white focus:outline-none focus:border-indigo-500"
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-semibold text-slate-300 uppercase mb-2">Password</label>
              <div className="relative">
                <Lock className="absolute left-3 top-3.5 text-slate-500 w-5 h-5" />
                <input
                  type="password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-4 py-3 bg-slate-900 border border-slate-700 rounded-xl text-white focus:outline-none focus:border-indigo-500"
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={authLoading}
              className="w-full py-3 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold rounded-xl flex items-center justify-center space-x-2 transition"
            >
              <span>{authLoading ? 'Authenticating...' : 'Sign In'}</span>
              <ArrowRight className="w-5 h-5" />
            </button>
          </form>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50 font-sans">
      {userProfile.role === 'admin' && <AdminPortal profile={userProfile} onLogout={handleLogout} />}
      {userProfile.role === 'cluster' && <ClusterPortal profile={userProfile} onLogout={handleLogout} />}
      {userProfile.role === 'exhibitor' && <ExhibitorPortal profile={userProfile} onLogout={handleLogout} />}
    </div>
  );
}

function ExhibitorPortal({ profile, onLogout }) {
  const [tab, setTab] = useState('new');
  const [reports, setReports] = useState([]);
  const [products, setProducts] = useState([]);
  const [submitting, setSubmitting] = useState(false);

  const [newProductName, setNewProductName] = useState('');
  const [newProductCategory, setNewProductCategory] = useState('');

  const [day, setDay] = useState('Day 1');
  const [staff, setStaff] = useState(0);
  const [visitors, setVisitors] = useState(0);
  const [engagements, setEngagements] = useState(0);
  const [conversions, setConversions] = useState(0);
  const [dignitaries, setDignitaries] = useState('');
  const [selectedExhibitedProducts, setSelectedExhibitedProducts] = useState([]);
  const [mostEngagedProduct, setMostEngagedProduct] = useState('');
  const [deals, setDeals] = useState('');
  const [requests, setRequests] = useState('');
  const [observations, setObservations] = useState('');
  const [challenges, setChallenges] = useState('');
  const [improvements, setImprovements] = useState('');

  useEffect(() => {
    fetchExhibitorData();
  }, []);

  const fetchExhibitorData = async () => {
    const { data: rData } = await supabase
      .from('exhibitor_daily_reports')
      .select('*')
      .eq('user_id', profile.id)
      .order('created_at', { ascending: false });
    if (rData) setReports(rData);

    const { data: pData } = await supabase
      .from('exhibitor_products')
      .select('*')
      .eq('user_id', profile.id)
      .order('created_at', { ascending: true });
    if (pData) setProducts(pData);
  };

  const handleAddProduct = async (e) => {
    e.preventDefault();
    if (!newProductName.trim()) return;
    const { error } = await supabase.from('exhibitor_products').insert([{
      user_id: profile.id,
      product_name: newProductName,
      category: newProductCategory
    }]);
    if (!error) {
      setNewProductName('');
      setNewProductCategory('');
      fetchExhibitorData();
    }
  };

  const handleDeleteProduct = async (productId) => {
    await supabase.from('exhibitor_products').delete().eq('id', productId);
    fetchExhibitorData();
  };

  const handleProductCheck = (prodName) => {
    if (selectedExhibitedProducts.includes(prodName)) {
      setSelectedExhibitedProducts(selectedExhibitedProducts.filter(p => p !== prodName));
    } else {
      setSelectedExhibitedProducts([...selectedExhibitedProducts, prodName]);
    }
  };

  const handleSubmitReport = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    const rate = visitors > 0 ? ((conversions / visitors) * 100).toFixed(2) : 0;

    const { error } = await supabase.from('exhibitor_daily_reports').insert([{
      user_id: profile.id,
      exhibitor_name: profile.entity_name,
      pavilion: 'Exhibition Pavilion',
      exhibition_day: day,
      number_of_staff_on_stand: parseInt(staff),
      number_of_visitors_recorded: parseInt(visitors),
      total_number_of_engagements: parseInt(engagements),
      total_number_of_conversions: parseInt(conversions),
      conversion_rate: parseFloat(rate),
      list_of_dignitaries_received: dignitaries,
      list_of_products_exhibited: selectedExhibitedProducts.join(', '),
      most_engaged_product_for_the_day: mostEngagedProduct,
      significant_deals_partnerships_secured: deals,
      new_requests_received: requests,
      key_observations: observations,
      challenges_and_recommendations: challenges,
      improvements_for_next_day: improvements
    }]);

    setSubmitting(false);
    if (!error) {
      fetchExhibitorData();
      setTab('entries');
    }
  };

  const totalVisitors = reports.reduce((acc, r) => acc + (r.number_of_visitors_recorded || 0), 0);
  const totalConversions = reports.reduce((acc, r) => acc + (r.total_number_of_conversions || 0), 0);
  const avgRate = reports.length > 0 ? (reports.reduce((acc, r) => acc + (parseFloat(r.conversion_rate) || 0), 0) / reports.length).toFixed(1) : 0;

  return (
    <div className="flex flex-col min-h-screen">
      <header className="bg-white border-b border-slate-200 px-6 py-4 flex justify-between items-center shadow-sm">
        <div>
          <h1 className="text-xl font-bold text-slate-800">Exhibitor Portal — {profile.entity_name}</h1>
        </div>
        <button onClick={onLogout} className="text-sm font-medium text-red-600 flex items-center space-x-1 hover:underline">
          <LogOut className="w-4 h-4" /> <span>Sign Out</span>
        </button>
      </header>

      <div className="bg-white border-b border-slate-200 px-6 flex space-x-8">
        <button onClick={() => setTab('new')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-2 ${tab === 'new' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <Plus className="w-4 h-4" /> <span>Daily Report</span>
        </button>
        <button onClick={() => setTab('catalog')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-2 ${tab === 'catalog' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <Package className="w-4 h-4" /> <span>Product Catalog ({products.length})</span>
        </button>
        <button onClick={() => setTab('entries')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-2 ${tab === 'entries' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <FileText className="w-4 h-4" /> <span>My Entries ({reports.length})</span>
        </button>
        <button onClick={() => setTab('analytics')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-2 ${tab === 'analytics' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <BarChart3 className="w-4 h-4" /> <span>Analytics</span>
        </button>
        <button onClick={() => setTab('feedback')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-2 ${tab === 'feedback' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <MessageSquare className="w-4 h-4" /> <span>Admin Feedback</span>
        </button>
      </div>

      <main className="flex-1 max-w-5xl w-full mx-auto px-6 py-8">
        {tab === 'catalog' && (
          <div className="space-y-6">
            <form onSubmit={handleAddProduct} className="bg-white border rounded-2xl p-6 shadow-sm flex items-end space-x-4">
              <div className="flex-1">
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Product / Book / Service Name</label>
                <input type="text" required placeholder="e.g. Rhapsody of Realities" value={newProductName} onChange={e => setNewProductName(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
              <div className="w-64">
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Category (Optional)</label>
                <input type="text" placeholder="e.g. Print, Digital" value={newProductCategory} onChange={e => setNewProductCategory(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
              <button type="submit" className="px-6 py-3 bg-indigo-600 text-white font-bold rounded-xl flex items-center space-x-2 hover:bg-indigo-500">
                <Plus className="w-5 h-5" /> <span>Add Product</span>
              </button>
            </form>

            <div className="bg-white border rounded-2xl p-6 shadow-sm">
              <h3 className="font-bold text-slate-800 text-lg mb-4">Your Product Catalog</h3>
              {products.length === 0 ? (
                <p className="text-slate-400 text-sm italic">No products added yet. Add items above to select them easily in daily reports.</p>
              ) : (
                <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
                  {products.map(p => (
                    <div key={p.id} className="p-4 border rounded-xl bg-slate-50 flex justify-between items-center">
                      <div>
                        <p className="font-bold text-slate-800">{p.product_name}</p>
                        {p.category && <span className="text-xs text-indigo-600 font-medium">{p.category}</span>}
                      </div>
                      <button onClick={() => handleDeleteProduct(p.id)} className="text-slate-400 hover:text-red-500 p-1">
                        <Trash2 className="w-4 h-4" />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        )}

        {tab === 'new' && (
          <form onSubmit={handleSubmitReport} className="bg-white border rounded-2xl p-8 space-y-6 shadow-sm">
            <h2 className="text-lg font-bold text-slate-800 border-b pb-3">Submit Daily Exhibitor Metrics</h2>
            
            <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Exhibition Day</label>
                <select value={day} onChange={e => setDay(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800">
                  {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
                </select>
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Staff On Stand</label>
                <input type="number" required value={staff} onChange={e => setStaff(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Visitors Recorded</label>
                <input type="number" required value={visitors} onChange={e => setVisitors(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Total Engagements</label>
                <input type="number" required value={engagements} onChange={e => setEngagements(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
              <div>
                <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Total Conversions</label>
                <input type="number" required value={conversions} onChange={e => setConversions(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
              </div>
            </div>

            <div className="border border-indigo-100 bg-indigo-50/40 rounded-2xl p-6 space-y-4">
              <div className="flex justify-between items-center">
                <label className="block text-xs font-bold text-indigo-900 uppercase">Select Products Exhibited Today</label>
                <button type="button" onClick={() => setTab('catalog')} className="text-xs font-semibold text-indigo-600 hover:underline">
                  + Add items to catalog
                </button>
              </div>

              {products.length === 0 ? (
                <div className="p-4 bg-white border rounded-xl text-center text-sm text-slate-500">
                  No products in your catalog yet. Click <button type="button" onClick={() => setTab('catalog')} className="text-indigo-600 font-bold underline">here</button> to create your product list.
                </div>
              ) : (
                <div className="grid grid-cols-2 md:grid-cols-3 gap-3 max-h-48 overflow-y-auto p-2 bg-white rounded-xl border">
                  {products.map(p => (
                    <label key={p.id} className={`flex items-center space-x-2 p-2 rounded-lg border cursor-pointer text-sm font-medium ${selectedExhibitedProducts.includes(p.product_name) ? 'bg-indigo-600 text-white border-indigo-600' : 'bg-slate-50 text-slate-700'}`}>
                      <input type="checkbox" checked={selectedExhibitedProducts.includes(p.product_name)} onChange={() => handleProductCheck(p.product_name)} className="hidden" />
                      <span>{p.product_name}</span>
                    </label>
                  ))}
                </div>
              )}

              <div>
                <label className="block text-xs font-bold text-indigo-900 uppercase mb-1">Most Engaged Product for the Day</label>
                <select value={mostEngagedProduct} onChange={e => setMostEngagedProduct(e.target.value)} className="w-full p-3 border rounded-xl bg-white text-slate-800">
                  <option value="">Select from catalog...</option>
                  {products.map(p => (
                    <option key={p.id} value={p.product_name}>{p.product_name}</option>
                  ))}
                </select>
              </div>
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Dignitaries Received</label>
              <textarea rows={2} value={dignitaries} onChange={e => setDignitaries(e.target.value)} placeholder="Government officials, corporate leaders..." className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Deals / Partnerships Secured</label>
              <textarea rows={2} value={deals} onChange={e => setDeals(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
            </div>

            <div>
              <label className="block text-xs font-bold text-slate-600 uppercase mb-1">Key Observations & Improvements</label>
              <textarea rows={3} value={observations} onChange={e => setObservations(e.target.value)} className="w-full p-3 border rounded-xl bg-slate-50 text-slate-800" />
            </div>

            <button type="submit" disabled={submitting} className="w-full py-4 bg-indigo-600 text-white font-bold rounded-xl shadow-md flex items-center justify-center space-x-2 hover:bg-indigo-500">
              <Send className="w-5 h-5" />
              <span>{submitting ? 'Submitting...' : 'Submit Daily Report'}</span>
            </button>
          </form>
        )}

        {tab === 'entries' && (
          <div className="space-y-4">
            {reports.map(r => (
              <div key={r.id} className="bg-white border border-slate-200 rounded-2xl p-6 shadow-sm">
                <div className="flex justify-between items-center mb-4">
                  <span className="font-bold text-indigo-600 text-lg">{r.exhibition_day}</span>
                  <span className="text-xs bg-slate-100 text-slate-600 px-3 py-1 rounded-full font-semibold">{new Date(r.created_at).toLocaleDateString()}</span>
                </div>
                <div className="grid grid-cols-4 gap-4 text-center bg-slate-50 p-4 rounded-xl mb-4">
                  <div><p className="text-xs text-slate-500">Staff</p><p className="font-bold text-slate-800">{r.number_of_staff_on_stand}</p></div>
                  <div><p className="text-xs text-slate-500">Visitors</p><p className="font-bold text-slate-800">{r.number_of_visitors_recorded}</p></div>
                  <div><p className="text-xs text-slate-500">Conversions</p><p className="font-bold text-emerald-600">{r.total_number_of_conversions}</p></div>
                  <div><p className="text-xs text-slate-500">Rate</p><p className="font-bold text-indigo-600">{r.conversion_rate}%</p></div>
                </div>
              </div>
            ))}
          </div>
        )}

        {tab === 'analytics' && (
          <div className="grid grid-cols-3 gap-6">
            <div className="bg-white p-6 rounded-2xl border shadow-sm text-center">
              <p className="text-slate-500 text-sm">Total Visitors</p>
              <h3 className="text-4xl font-bold text-slate-800 mt-2">{totalVisitors}</h3>
            </div>
            <div className="bg-white p-6 rounded-2xl border shadow-sm text-center">
              <p className="text-slate-500 text-sm">Total Conversions</p>
              <h3 className="text-4xl font-bold text-emerald-600 mt-2">{totalConversions}</h3>
            </div>
            <div className="bg-white p-6 rounded-2xl border shadow-sm text-center">
              <p className="text-slate-500 text-sm">Average Conversion Rate</p>
              <h3 className="text-4xl font-bold text-indigo-600 mt-2">{avgRate}%</h3>
            </div>
          </div>
        )}

        {tab === 'feedback' && (
          <div className="space-y-4">
            {reports.filter(r => r.admin_feedback).map(r => (
              <div key={r.id} className="bg-indigo-50/50 border border-indigo-200 rounded-2xl p-6">
                <div className="flex justify-between items-center mb-2">
                  <span className="font-bold text-slate-800">{r.exhibition_day} Feedback</span>
                  <span className="text-xs text-indigo-600 font-semibold">{new Date(r.feedback_given_at).toLocaleDateString()}</span>
                </div>
                <p className="text-slate-700 bg-white p-4 rounded-xl border border-indigo-100">{r.admin_feedback}</p>
              </div>
            ))}
            {reports.filter(r => r.admin_feedback).length === 0 && (
              <div className="text-center p-12 text-slate-400">No admin feedback received yet.</div>
            )}
          </div>
        )}
      </main>
    </div>
  );
}

function ClusterPortal({ profile, onLogout }) {
  const [tab, setTab] = useState('daily');
  const [dailyReports, setDailyReports] = useState([]);
  const [finalReports, setFinalReports] = useState([]);
  const [submitting, setSubmitting] = useState(false);

  const [subchairman, setSubchairman] = useState('');
  const [secretary, setSecretary] = useState('');
  const [day, setDay] = useState('Day 1');
  const [activities, setActivities] = useState('');
  const [achievements, setAchievements] = useState('');
  const [challenges, setChallenges] = useState('');
  const [improvements, setImprovements] = useState('');

  const [expoSummary, setExpoSummary] = useState('');
  const [milestones, setMilestones] = useState('');
  const [deliverables, setDeliverables] = useState('');
  const [recommendations, setRecommendations] = useState('');

  useEffect(() => {
    fetchClusterData();
  }, []);

  const fetchClusterData = async () => {
    const { data: dData } = await supabase.from('cluster_daily_reports').select('*').eq('user_id', profile.id);
    const { data: fData } = await supabase.from('cluster_final_reports').select('*').eq('user_id', profile.id);
    if (dData) setDailyReports(dData);
    if (fData) setFinalReports(fData);
  };

  const handleDailySubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    await supabase.from('cluster_daily_reports').insert([{
      user_id: profile.id,
      cluster: profile.entity_name,
      cluster_subchairman: subchairman,
      cluster_secretary: secretary,
      exhibition_day: day,
      summary_of_activities: activities,
      significant_achievements: achievements,
      challenges_and_solutions_proferred: challenges,
      improvements_for_next_day: improvements
    }]);

    setSubmitting(false);
    fetchClusterData();
    setTab('entries');
  };

  const handleFinalSubmit = async (e) => {
    e.preventDefault();
    setSubmitting(true);
    await supabase.from('cluster_final_reports').insert([{
      user_id: profile.id,
      cluster: profile.entity_name,
      cluster_subchairman: subchairman,
      cluster_secretary: secretary,
      overall_expo_summary: expoSummary,
      key_milestones_achieved: milestones,
      total_cluster_deliverables_summary: deliverables,
      recommendations_for_future_expo: recommendations
    }]);

    setSubmitting(false);
    fetchClusterData();
    setTab('entries');
  };

  return (
    <div className="flex flex-col min-h-screen">
      <header className="bg-white border-b border-slate-200 px-6 py-4 flex justify-between items-center shadow-sm">
        <h1 className="text-xl font-bold text-slate-800">Cluster Portal — {profile.entity_name}</h1>
        <button onClick={onLogout} className="text-sm font-medium text-red-600 flex items-center space-x-1 hover:underline">
          <LogOut className="w-4 h-4" /> <span>Sign Out</span>
        </button>
      </header>

      <div className="bg-white border-b border-slate-200 px-6 flex space-x-8">
        <button onClick={() => setTab('daily')} className={`py-4 font-semibold text-sm border-b-2 ${tab === 'daily' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          Daily Report
        </button>
        <button onClick={() => setTab('final')} className={`py-4 font-semibold text-sm border-b-2 flex items-center space-x-1 ${tab === 'final' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          <Award className="w-4 h-4 text-amber-500" /> <span>Final Summary Report</span>
        </button>
        <button onClick={() => setTab('entries')} className={`py-4 font-semibold text-sm border-b-2 ${tab === 'entries' ? 'border-indigo-600 text-indigo-600' : 'border-transparent text-slate-500'}`}>
          Submissions ({dailyReports.length + finalReports.length})
        </button>
      </div>

      <main className="flex-1 max-w-4xl w-full mx-auto px-6 py-8">
        {tab === 'daily' && (
          <form onSubmit={handleDailySubmit} className="bg-white border rounded-2xl p-8 space-y-6 shadow-sm">
            <h2 className="text-lg font-bold text-slate-800 border-b pb-3">Daily Cluster Delivery Report</h2>
            <div className="grid grid-cols-3 gap-4">
              <input type="text" required placeholder="Subchairman Name" value={subchairman} onChange={e => setSubchairman(e.target.value)} className="p-3 border rounded-xl text-slate-800" />
              <input type="text" required placeholder="Secretary Name" value={secretary} onChange={e => setSecretary(e.target.value)} className="p-3 border rounded-xl text-slate-800" />
              <select value={day} onChange={e => setDay(e.target.value)} className="p-3 border rounded-xl text-slate-800">
                {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
              </select>
            </div>
            <textarea required rows={3} placeholder="Summary of activities for the day *" value={activities} onChange={e => setActivities(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Significant Achievements *" value={achievements} onChange={e => setAchievements(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Challenges & Solutions *" value={challenges} onChange={e => setChallenges(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Improvements for next day *" value={improvements} onChange={e => setImprovements(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <button type="submit" disabled={submitting} className="w-full py-4 bg-indigo-600 text-white font-bold rounded-xl shadow-md hover:bg-indigo-500">
              {submitting ? 'Submitting...' : 'Submit Daily Report'}
            </button>
          </form>
        )}

        {tab === 'final' && (
          <form onSubmit={handleFinalSubmit} className="bg-white border rounded-2xl p-8 space-y-6 shadow-sm border-amber-200">
            <div className="flex items-center space-x-2 text-amber-600 border-b pb-3">
              <Award className="w-6 h-6" />
              <h2 className="text-lg font-bold text-slate-800">Final Expo Summary Report</h2>
            </div>
            <textarea required rows={4} placeholder="Overall Expo Cluster Summary *" value={expoSummary} onChange={e => setExpoSummary(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Key Milestones Achieved *" value={milestones} onChange={e => setMilestones(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Total Cluster Deliverables Summary *" value={deliverables} onChange={e => setDeliverables(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <textarea required rows={3} placeholder="Recommendations for Future Expo *" value={recommendations} onChange={e => setRecommendations(e.target.value)} className="w-full p-3 border rounded-xl text-slate-800" />
            <button type="submit" disabled={submitting} className="w-full py-4 bg-amber-600 text-white font-bold rounded-xl shadow-md hover:bg-amber-500">
              {submitting ? 'Submitting...' : 'Submit Final Summary Report'}
            </button>
          </form>
        )}
      </main>
    </div>
  );
}

function AdminPortal({ profile, onLogout }) {
  const [exhibitorReports, setExhibitorReports] = useState([]);
  const [clusterDaily, setClusterDaily] = useState([]);
  const [feedbackText, setFeedbackText] = useState({});

  useEffect(() => {
    fetchAllReports();
  }, []);

  const fetchAllReports = async () => {
    const { data: eData } = await supabase.from('exhibitor_daily_reports').select('*').order('created_at', { ascending: false });
    const { data: cdData } = await supabase.from('cluster_daily_reports').select('*').order('created_at', { ascending: false });
    if (eData) setExhibitorReports(eData);
    if (cdData) setClusterDaily(cdData);
  };

  const submitFeedback = async (table, id) => {
    const text = feedbackText[id];
    if (!text) return;

    await supabase.from(table).update({
      admin_feedback: text,
      feedback_given_at: new Date().toISOString(),
      status: 'reviewed'
    }).eq('id', id);

    fetchAllReports();
    alert('Feedback sent!');
  };

  return (
    <div className="min-h-screen bg-slate-100 flex flex-col">
      <header className="bg-slate-900 text-white px-6 py-4 flex justify-between items-center">
        <div className="flex items-center space-x-3">
          <Shield className="w-7 h-7 text-indigo-400" />
          <h1 className="text-xl font-bold">Loveworld Expo — Executive Admin Oversight</h1>
        </div>
        <button onClick={onLogout} className="px-4 py-2 bg-slate-800 text-sm font-semibold rounded-lg text-red-400 hover:bg-slate-700">
          Sign Out
        </button>
      </header>

      <main className="max-w-7xl w-full mx-auto px-6 py-8 space-y-8">
        <div className="grid grid-cols-3 gap-6">
          <div className="bg-white p-6 rounded-2xl border shadow-sm">
            <p className="text-slate-500 text-xs font-bold uppercase">Exhibitor Submissions</p>
            <h3 className="text-3xl font-bold text-slate-800 mt-1">{exhibitorReports.length}</h3>
          </div>
          <div className="bg-white p-6 rounded-2xl border shadow-sm">
            <p className="text-slate-500 text-xs font-bold uppercase">Cluster Daily Reports</p>
            <h3 className="text-3xl font-bold text-slate-800 mt-1">{clusterDaily.length}</h3>
          </div>
          <div className="bg-white p-6 rounded-2xl border shadow-sm">
            <p className="text-slate-500 text-xs font-bold uppercase">Total Expo Visitors</p>
            <h3 className="text-3xl font-bold text-indigo-600 mt-1">
              {exhibitorReports.reduce((acc, r) => acc + (r.number_of_visitors_recorded || 0), 0)}
            </h3>
          </div>
        </div>

        <div className="bg-white rounded-2xl border p-6 shadow-sm">
          <h2 className="text-lg font-bold text-slate-800 mb-4">Exhibitor Reports & Admin Feedback</h2>
          <div className="space-y-4">
            {exhibitorReports.map(r => (
              <div key={r.id} className="p-4 border rounded-xl bg-slate-50 flex justify-between items-start">
                <div className="space-y-1">
                  <span className="font-bold text-indigo-600">{r.exhibitor_name} ({r.exhibition_day})</span>
                  <p className="text-sm text-slate-600">Visitors: {r.number_of_visitors_recorded} | Conversions: {r.total_number_of_conversions}</p>
                  <p className="text-xs text-slate-500">Exhibited: {r.list_of_products_exhibited}</p>
                </div>
                <div className="w-80 space-y-2">
                  <textarea
                    rows={2}
                    placeholder="Provide admin feedback..."
                    value={feedbackText[r.id] || r.admin_feedback || ''}
                    onChange={e => setFeedbackText({ ...feedbackText, [r.id]: e.target.value })}
                    className="w-full p-2 border text-xs rounded-lg bg-white text-slate-800"
                  />
                  <button onClick={() => submitFeedback('exhibitor_daily_reports', r.id)} className="w-full py-1.5 bg-indigo-600 text-white text-xs font-bold rounded-lg flex items-center justify-center space-x-1 hover:bg-indigo-500">
                    <Send className="w-3 h-3" /> <span>Save Feedback</span>
                  </button>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  );
}
