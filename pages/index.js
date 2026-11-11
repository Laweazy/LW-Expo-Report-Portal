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
      <div style={{ minHeight: '100vh', backgroundColor: '#0f172a', display: 'flex', alignItems: 'center', justifyContent: 'center', color: 'white', fontFamily: 'sans-serif' }}>
        <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '16px' }}>
          <div style={{ width: '40px', height: '40px', border: '4px solid #6366f1', borderTopColor: 'transparent', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
          <p style={{ color: '#94a3b8', fontSize: '14px', fontWeight: 500 }}>Loading Loveworld Expo Portal...</p>
        </div>
      </div>
    );
  }

  if (!session || !userProfile) {
    return (
      <div style={{ minHeight: '100vh', display: 'flex', alignItems: 'center', justifyContent: 'center', backgroundColor: '#0f172a', padding: '16px', fontFamily: 'sans-serif' }}>
        <div style={{ maxWidth: '400px', width: '100%', backgroundColor: '#1e293b', border: '1px solid #334155', borderRadius: '16px', padding: '32px', boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)' }}>
          <div style={{ textAlign: 'center', marginBottom: '32px' }}>
            <div style={{ display: 'inline-flex', padding: '12px', backgroundColor: 'rgba(99, 102, 241, 0.2)', color: '#818cf8', borderRadius: '12px', marginBottom: '12px' }}>
              <Shield style={{ width: '32px', height: '32px' }} />
            </div>
            <h1 style={{ fontSize: '24px', fontWeight: 'bold', color: 'white', margin: 0 }}>Loveworld Expo Portal</h1>
            <p style={{ color: '#94a3b8', fontSize: '14px', marginTop: '4px' }}>Sign in with your assigned credentials</p>
          </div>

          {authError && (
            <div style={{ marginBottom: '16px', padding: '12px', backgroundColor: 'rgba(239, 68, 68, 0.1)', border: '1px solid rgba(239, 68, 68, 0.3)', color: '#f87171', borderRadius: '12px', fontSize: '14px' }}>
              {authError}
            </div>
          )}

          <form onSubmit={handleLogin} style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            <div>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: '600', color: '#cbd5e1', textTransform: 'uppercase', marginBottom: '8px' }}>Email</label>
              <div style={{ position: 'relative' }}>
                <Mail style={{ position: 'absolute', left: '12px', top: '14px', color: '#64748b', width: '20px', height: '20px' }} />
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="cluster1@loveworldexpo.org"
                  style={{ width: '100%', paddingLeft: '40px', paddingRight: '16px', paddingTop: '12px', paddingBottom: '12px', backgroundColor: '#0f172a', border: '1px solid #334155', borderRadius: '12px', color: 'white', outline: 'none', boxSizing: 'border-box' }}
                />
              </div>
            </div>

            <div>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: '600', color: '#cbd5e1', textTransform: 'uppercase', marginBottom: '8px' }}>Password</label>
              <div style={{ position: 'relative' }}>
                <Lock style={{ position: 'absolute', left: '12px', top: '14px', color: '#64748b', width: '20px', height: '20px' }} />
                <input
                  type="password"
                  required
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  placeholder="••••••••"
                  style={{ width: '100%', paddingLeft: '40px', paddingRight: '16px', paddingTop: '12px', paddingBottom: '12px', backgroundColor: '#0f172a', border: '1px solid #334155', borderRadius: '12px', color: 'white', outline: 'none', boxSizing: 'border-box' }}
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={authLoading}
              style={{ width: '100%', paddingTop: '12px', paddingBottom: '12px', backgroundColor: '#4f46e5', color: 'white', fontWeight: '600', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px', border: 'none', cursor: 'pointer', marginTop: '8px' }}
            >
              <span>{authLoading ? 'Authenticating...' : 'Sign In'}</span>
              <ArrowRight style={{ width: '20px', height: '20px' }} />
            </button>
          </form>
        </div>
      </div>
    );
  }

  return (
    <div style={{ minHeight: '100vh', backgroundColor: '#f8fafc', fontFamily: 'sans-serif' }}>
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
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <header style={{ backgroundColor: 'white', borderBottom: '1px solid #e2e8f0', padding: '16px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h1 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', margin: 0 }}>Exhibitor Portal — {profile.entity_name}</h1>
        <button onClick={onLogout} style={{ background: 'none', border: 'none', color: '#dc2626', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}>
          <LogOut style={{ width: '16px', height: '16px' }} /> <span>Sign Out</span>
        </button>
      </header>

      <div style={{ backgroundColor: 'white', borderBottom: '1px solid #e2e8f0', paddingLeft: '24px', display: 'flex', gap: '32px' }}>
        {['new', 'catalog', 'entries', 'analytics', 'feedback'].map((t) => (
          <button
            key={t}
            onClick={() => setTab(t)}
            style={{
              padding: '16px 0',
              fontWeight: '600',
              fontSize: '14px',
              background: 'none',
              border: 'none',
              borderBottom: tab === t ? '2px solid #4f46e5' : '2px solid transparent',
              color: tab === t ? '#4f46e5' : '#64748b',
              cursor: 'pointer',
              textTransform: 'capitalize'
            }}
          >
            {t === 'new' ? 'Daily Report' : t === 'catalog' ? `Product Catalog (${products.length})` : t === 'entries' ? `My Entries (${reports.length})` : t}
          </button>
        ))}
      </div>

      <main style={{ maxWidth: '1000px', width: '100%', margin: '0 auto', padding: '32px 24px', boxSizing: 'border-box' }}>
        {tab === 'catalog' && (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
            <form onSubmit={handleAddProduct} style={{ backgroundColor: 'white', border: '1px solid #e2e8f0', borderRadius: '16px', padding: '24px', display: 'flex', alignItems: 'flex-end', gap: '16px' }}>
              <div style={{ flex: 1 }}>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Product / Book / Service Name</label>
                <input type="text" required placeholder="e.g. Rhapsody of Realities" value={newProductName} onChange={e => setNewProductName(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
              <div style={{ width: '250px' }}>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Category</label>
                <input type="text" placeholder="e.g. Print, Digital" value={newProductCategory} onChange={e => setNewProductCategory(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
              <button type="submit" style={{ padding: '12px 24px', backgroundColor: '#4f46e5', color: 'white', fontWeight: 'bold', borderRadius: '12px', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Plus style={{ width: '20px', height: '20px' }} /> <span>Add Product</span>
              </button>
            </form>

            <div style={{ backgroundColor: 'white', border: '1px solid #e2e8f0', borderRadius: '16px', padding: '24px' }}>
              <h3 style={{ fontWeight: 'bold', color: '#1e293b', fontSize: '18px', marginBottom: '16px' }}>Your Product Catalog</h3>
              {products.length === 0 ? (
                <p style={{ color: '#94a3b8', fontSize: '14px', fontStyle: 'italic' }}>No products added yet. Add items above to select them easily in daily reports.</p>
              ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '16px' }}>
                  {products.map(p => (
                    <div key={p.id} style={{ padding: '16px', border: '1px solid #e2e8f0', borderRadius: '12px', backgroundColor: '#f8fafc', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <div>
                        <p style={{ fontWeight: 'bold', color: '#1e293b', margin: 0 }}>{p.product_name}</p>
                        {p.category && <span style={{ fontSize: '12px', color: '#4f46e5', fontWeight: '500' }}>{p.category}</span>}
                      </div>
                      <button onClick={() => handleDeleteProduct(p.id)} style={{ background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer' }}>
                        <Trash2 style={{ width: '16px', height: '16px' }} />
                      </button>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </div>
        )}

        {tab === 'new' && (
          <form onSubmit={handleSubmitReport} style={{ backgroundColor: 'white', border: '1px solid #e2e8f0', borderRadius: '16px', padding: '32px', display: 'flex', flexDirection: 'column', gap: '24px' }}>
            <h2 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', borderBottom: '1px solid #e2e8f0', paddingBottom: '12px', margin: 0 }}>Submit Daily Exhibitor Metrics</h2>
            
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '16px' }}>
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Exhibition Day</label>
                <select value={day} onChange={e => setDay(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }}>
                  {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
                </select>
              </div>
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Staff On Stand</label>
                <input type="number" required value={staff} onChange={e => setStaff(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Visitors Recorded</label>
                <input type="number" required value={visitors} onChange={e => setVisitors(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: '16px' }}>
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Total Engagements</label>
                <input type="number" required value={engagements} onChange={e => setEngagements(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Total Conversions</label>
                <input type="number" required value={conversions} onChange={e => setConversions(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
              </div>
            </div>

            <div style={{ border: '1px solid #e0e7ff', backgroundColor: '#eef2ff', borderRadius: '16px', padding: '24px', display: 'flex', flexDirection: 'column', gap: '16px' }}>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#312e81', textTransform: 'uppercase' }}>Select Products Exhibited Today</label>
              {products.length === 0 ? (
                <p style={{ fontSize: '14px', color: '#64748b' }}>No products in your catalog yet. Add items in the Product Catalog tab first.</p>
              ) : (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '12px', maxHeight: '180px', overflowY: 'auto' }}>
                  {products.map(p => (
                    <label key={p.id} onClick={() => handleProductCheck(p.product_name)} style={{ padding: '10px 14px', borderRadius: '8px', border: '1px solid #c7d2fe', cursor: 'pointer', backgroundColor: selectedExhibitedProducts.includes(p.product_name) ? '#4f46e5' : 'white', color: selectedExhibitedProducts.includes(p.product_name) ? 'white' : '#1e293b', fontWeight: '500', fontSize: '14px' }}>
                      {p.product_name}
                    </label>
                  ))}
                </div>
              )}
              <div>
                <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#312e81', textTransform: 'uppercase', marginBottom: '4px' }}>Most Engaged Product for the Day</label>
                <select value={mostEngagedProduct} onChange={e => setMostEngagedProduct(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: 'white', color: '#1e293b', boxSizing: 'border-box' }}>
                  <option value="">Select from catalog...</option>
                  {products.map(p => <option key={p.id} value={p.product_name}>{p.product_name}</option>)}
                </select>
              </div>
            </div>

            <div>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Dignitaries Received</label>
              <textarea rows={2} value={dignitaries} onChange={e => setDignitaries(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
            </div>

            <div>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Deals / Partnerships Secured</label>
              <textarea rows={2} value={deals} onChange={e => setDeals(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
            </div>

            <div>
              <label style={{ display: 'block', fontSize: '12px', fontWeight: 'bold', color: '#475569', textTransform: 'uppercase', marginBottom: '4px' }}>Key Observations & Improvements</label>
              <textarea rows={3} value={observations} onChange={e => setObservations(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', backgroundColor: '#f8fafc', color: '#1e293b', boxSizing: 'border-box' }} />
            </div>

            <button type="submit" disabled={submitting} style={{ width: '100%', padding: '16px', backgroundColor: '#4f46e5', color: 'white', fontWeight: 'bold', borderRadius: '12px', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px' }}>
              <Send style={{ width: '20px', height: '20px' }} />
              <span>{submitting ? 'Submitting...' : 'Submit Daily Report'}</span>
            </button>
          </form>
        )}

        {tab === 'entries' && (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            {reports.map(r => (
              <div key={r.id} style={{ backgroundColor: 'white', border: '1px solid #e2e8f0', borderRadius: '16px', padding: '24px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                  <span style={{ fontWeight: 'bold', color: '#4f46e5', fontSize: '18px' }}>{r.exhibition_day}</span>
                  <span style={{ fontSize: '12px', backgroundColor: '#f1f5f9', color: '#475569', padding: '4px 12px', borderRadius: '9999px', fontWeight: '600' }}>{new Date(r.created_at).toLocaleDateString()}</span>
                </div>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', textAlign: 'center', backgroundColor: '#f8fafc', padding: '16px', borderRadius: '12px' }}>
                  <div><p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>Staff</p><p style={{ fontWeight: 'bold', color: '#1e293b', margin: '4px 0 0 0' }}>{r.number_of_staff_on_stand}</p></div>
                  <div><p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>Visitors</p><p style={{ fontWeight: 'bold', color: '#1e293b', margin: '4px 0 0 0' }}>{r.number_of_visitors_recorded}</p></div>
                  <div><p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>Conversions</p><p style={{ fontWeight: 'bold', color: '#059669', margin: '4px 0 0 0' }}>{r.total_number_of_conversions}</p></div>
                  <div><p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>Rate</p><p style={{ fontWeight: 'bold', color: '#4f46e5', margin: '4px 0 0 0' }}>{r.conversion_rate}%</p></div>
                </div>
              </div>
            ))}
          </div>
        )}

        {tab === 'analytics' && (
          <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '24px' }}>
            <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0', textAlign: 'center' }}>
              <p style={{ color: '#64748b', fontSize: '14px', margin: 0 }}>Total Visitors</p>
              <h3 style={{ fontSize: '36px', fontWeight: 'bold', color: '#1e293b', margin: '8px 0 0 0' }}>{totalVisitors}</h3>
            </div>
            <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0', textAlign: 'center' }}>
              <p style={{ color: '#64748b', fontSize: '14px', margin: 0 }}>Total Conversions</p>
              <h3 style={{ fontSize: '36px', fontWeight: 'bold', color: '#059669', margin: '8px 0 0 0' }}>{totalConversions}</h3>
            </div>
            <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0', textAlign: 'center' }}>
              <p style={{ color: '#64748b', fontSize: '14px', margin: 0 }}>Average Conversion Rate</p>
              <h3 style={{ fontSize: '36px', fontWeight: 'bold', color: '#4f46e5', margin: '8px 0 0 0' }}>{avgRate}%</h3>
            </div>
          </div>
        )}

        {tab === 'feedback' && (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            {reports.filter(r => r.admin_feedback).map(r => (
              <div key={r.id} style={{ backgroundColor: 'rgba(238, 242, 255, 0.5)', border: '1px solid #c7d2fe', borderRadius: '16px', padding: '24px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                  <span style={{ fontWeight: 'bold', color: '#1e293b' }}>{r.exhibition_day} Feedback</span>
                  <span style={{ fontSize: '12px', color: '#4f46e5', fontWeight: '600' }}>{new Date(r.feedback_given_at).toLocaleDateString()}</span>
                </div>
                <p style={{ color: '#334155', backgroundColor: 'white', padding: '16px', borderRadius: '12px', border: '1px solid #e0e7ff', margin: 0 }}>{r.admin_feedback}</p>
              </div>
            ))}
            {reports.filter(r => r.admin_feedback).length === 0 && (
              <div style={{ textAlign: 'center', padding: '48px', color: '#94a3b8' }}>No admin feedback received yet.</div>
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
    <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
      <header style={{ backgroundColor: 'white', borderBottom: '1px solid #e2e8f0', padding: '16px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <h1 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', margin: 0 }}>Cluster Portal — {profile.entity_name}</h1>
        <button onClick={onLogout} style={{ background: 'none', border: 'none', color: '#dc2626', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}>
          <LogOut style={{ width: '16px', height: '16px' }} /> <span>Sign Out</span>
        </button>
      </header>

      <div style={{ backgroundColor: 'white', borderBottom: '1px solid #e2e8f0', paddingLeft: '24px', display: 'flex', gap: '32px' }}>
        <button onClick={() => setTab('daily')} style={{ padding: '16px 0', fontWeight: '600', fontSize: '14px', background: 'none', border: 'none', borderBottom: tab === 'daily' ? '2px solid #4f46e5' : '2px solid transparent', color: tab === 'daily' ? '#4f46e5' : '#64748b', cursor: 'pointer' }}>Daily Report</button>
        <button onClick={() => setTab('final')} style={{ padding: '16px 0', fontWeight: '600', fontSize: '14px', background: 'none', border: 'none', borderBottom: tab === 'final' ? '2px solid #4f46e5' : '2px solid transparent', color: tab === 'final' ? '#4f46e5' : '#64748b', cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '4px' }}><Award style={{ width: '16px', height: '16px', color: '#d97706' }} /> <span>Final Summary Report</span></button>
        <button onClick={() => setTab('entries')} style={{ padding: '16px 0', fontWeight: '600', fontSize: '14px', background: 'none', border: 'none', borderBottom: tab === 'entries' ? '2px solid #4f46e5' : '2px solid transparent', color: tab === 'entries' ? '#4f46e5' : '#64748b', cursor: 'pointer' }}>Submissions ({dailyReports.length + finalReports.length})</button>
      </div>

      <main style={{ maxWidth: '800px', width: '100%', margin: '0 auto', padding: '32px 24px', boxSizing: 'border-box' }}>
        {tab === 'daily' && (
          <form onSubmit={handleDailySubmit} style={{ backgroundColor: 'white', border: '1px solid #e2e8f0', borderRadius: '16px', padding: '32px', display: 'flex', flexDirection: 'column', gap: '20px' }}>
            <h2 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', borderBottom: '1px solid #e2e8f0', paddingBottom: '12px', margin: 0 }}>Daily Cluster Delivery Report</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '16px' }}>
              <input type="text" required placeholder="Subchairman Name" value={subchairman} onChange={e => setSubchairman(e.target.value)} style={{ padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
              <input type="text" required placeholder="Secretary Name" value={secretary} onChange={e => setSecretary(e.target.value)} style={{ padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
              <select value={day} onChange={e => setDay(e.target.value)} style={{ padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }}>
                {['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'].map(d => <option key={d} value={d}>{d}</option>)}
              </select>
            </div>
            <textarea required rows={3} placeholder="Summary of activities for the day *" value={activities} onChange={e => setActivities(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Significant Achievements *" value={achievements} onChange={e => setAchievements(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Challenges & Solutions *" value={challenges} onChange={e => setChallenges(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Improvements for next day *" value={improvements} onChange={e => setImprovements(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <button type="submit" disabled={submitting} style={{ width: '100%', padding: '16px', backgroundColor: '#4f46e5', color: 'white', fontWeight: 'bold', borderRadius: '12px', border: 'none', cursor: 'pointer' }}>
              {submitting ? 'Submitting...' : 'Submit Daily Report'}
            </button>
          </form>
        )}

        {tab === 'final' && (
          <form onSubmit={handleFinalSubmit} style={{ backgroundColor: 'white', border: '1px solid #fcd34d', borderRadius: '16px', padding: '32px', display: 'flex', flexDirection: 'column', gap: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#d97706', borderBottom: '1px solid #fef3c7', paddingBottom: '12px' }}>
              <Award style={{ width: '24px', height: '24px' }} />
              <h2 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', margin: 0 }}>Final Expo Summary Report</h2>
            </div>
            <textarea required rows={4} placeholder="Overall Expo Cluster Summary *" value={expoSummary} onChange={e => setExpoSummary(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Key Milestones Achieved *" value={milestones} onChange={e => setMilestones(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Total Cluster Deliverables Summary *" value={deliverables} onChange={e => setDeliverables(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <textarea required rows={3} placeholder="Recommendations for Future Expo *" value={recommendations} onChange={e => setRecommendations(e.target.value)} style={{ width: '100%', padding: '12px', border: '1px solid #cbd5e1', borderRadius: '12px', color: '#1e293b', boxSizing: 'border-box' }} />
            <button type="submit" disabled={submitting} style={{ width: '100%', padding: '16px', backgroundColor: '#d97706', color: 'white', fontWeight: 'bold', borderRadius: '12px', border: 'none', cursor: 'pointer' }}>
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
    <div style={{ minHeight: '100vh', backgroundColor: '#f1f5f9', display: 'flex', flexDirection: 'column' }}>
      <header style={{ backgroundColor: '#0f172a', color: 'white', padding: '16px 24px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
          <Shield style={{ width: '28px', height: '28px', color: '#818cf8' }} />
          <h1 style={{ fontSize: '18px', fontWeight: 'bold', margin: 0 }}>Loveworld Expo — Executive Admin Oversight</h1>
        </div>
        <button onClick={onLogout} style={{ padding: '8px 16px', backgroundColor: '#1e293b', color: '#f87171', border: 'none', borderRadius: '8px', fontWeight: '600', cursor: 'pointer' }}>
          Sign Out
        </button>
      </header>

      <main style={{ maxWidth: '1200px', width: '100%', margin: '0 auto', padding: '32px 24px', display: 'flex', flexDirection: 'column', gap: '32px', boxSizing: 'border-box' }}>
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '24px' }}>
          <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
            <p style={{ color: '#64748b', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', margin: 0 }}>Exhibitor Submissions</p>
            <h3 style={{ fontSize: '30px', fontWeight: 'bold', color: '#1e293b', margin: '4px 0 0 0' }}>{exhibitorReports.length}</h3>
          </div>
          <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
            <p style={{ color: '#64748b', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', margin: 0 }}>Cluster Daily Reports</p>
            <h3 style={{ fontSize: '30px', fontWeight: 'bold', color: '#1e293b', margin: '4px 0 0 0' }}>{clusterDaily.length}</h3>
          </div>
          <div style={{ backgroundColor: 'white', padding: '24px', borderRadius: '16px', border: '1px solid #e2e8f0' }}>
            <p style={{ color: '#64748b', fontSize: '12px', fontWeight: 'bold', textTransform: 'uppercase', margin: 0 }}>Total Expo Visitors</p>
            <h3 style={{ fontSize: '30px', fontWeight: 'bold', color: '#4f46e5', margin: '4px 0 0 0' }}>
              {exhibitorReports.reduce((acc, r) => acc + (r.number_of_visitors_recorded || 0), 0)}
            </h3>
          </div>
        </div>

        <div style={{ backgroundColor: 'white', borderRadius: '16px', border: '1px solid #e2e8f0', padding: '24px' }}>
          <h2 style={{ fontSize: '18px', fontWeight: 'bold', color: '#1e293b', marginBottom: '16px' }}>Exhibitor Reports & Admin Feedback</h2>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
            {exhibitorReports.map(r => (
              <div key={r.id} style={{ padding: '16px', border: '1px solid #e2e8f0', borderRadius: '12px', backgroundColor: '#f8fafc', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
                  <span style={{ fontWeight: 'bold', color: '#4f46e5' }}>{r.exhibitor_name} ({r.exhibition_day})</span>
                  <p style={{ fontSize: '14px', color: '#475569', margin: 0 }}>Visitors: {r.number_of_visitors_recorded} | Conversions: {r.total_number_of_conversions}</p>
                  <p style={{ fontSize: '12px', color: '#64748b', margin: 0 }}>Exhibited: {r.list_of_products_exhibited}</p>
                </div>
                <div style={{ width: '300px', display: 'flex', flexDirection: 'column', gap: '8px' }}>
                  <textarea
                    rows={2}
                    placeholder="Provide admin feedback..."
                    value={feedbackText[r.id] || r.admin_feedback || ''}
                    onChange={e => setFeedbackText({ ...feedbackText, [r.id]: e.target.value })}
                    style={{ width: '100%', padding: '8px', border: '1px solid #cbd5e1', fontSize: '12px', borderRadius: '8px', backgroundColor: 'white', color: '#1e293b', boxSizing: 'border-box' }}
                  />
                  <button onClick={() => submitFeedback('exhibitor_daily_reports', r.id)} style={{ width: '100%', padding: '8px', backgroundColor: '#4f46e5', color: 'white', fontSize: '12px', fontWeight: 'bold', borderRadius: '8px', border: 'none', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '4px' }}>
                    <Send style={{ width: '12px', height: '12px' }} /> <span>Save Feedback</span>
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
