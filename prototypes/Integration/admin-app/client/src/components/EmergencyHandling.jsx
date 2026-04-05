import React, { useState, useEffect } from 'react';
import { supabase } from '../supabaseClient';

const EmergencyHandling = () => {
  const [alerts, setAlerts] = useState([]);

  useEffect(() => {
    const fetchAlerts = async () => {
      const { data, error } = await supabase
        .from('emergency_alerts')
        .select(`
          *,
          buses ( bus_number )
        `)
        .order('severity_level', { ascending: false });

      if (error) {
        console.error('Error fetching emergency alerts:', error);
      } else {
        setAlerts(data);
      }
    };

    fetchAlerts();
    
    // Set up realtime listener for new alerts
    const subscription = supabase
      .channel('emergency_alerts_realtime')
      .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'emergency_alerts' }, payload => {
        setAlerts(current => [payload.new, ...current]);
      })
      .subscribe();

    return () => {
      supabase.removeChannel(subscription);
    };
  }, []);

  const getSeverityLabel = (level) => {
    switch (level) {
      case 3: return <span style={{color: '#ff4d4d', fontWeight: 'bold'}}>HIGH</span>;
      case 2: return <span style={{color: '#ffa64d', fontWeight: 'bold'}}>MEDIUM</span>;
      default: return <span style={{color: '#4da6ff'}}>LOW</span>;
    }
  };

  return (
    <div style={{padding: '20px'}}>
      <h1>🚨 Emergency Incident Control</h1>
      <p>Automated triage prioritizing life-critical incidents.</p>

      <table style={{width: '100%', borderCollapse: 'collapse', marginTop: '20px'}}>
        <thead>
          <tr style={{borderBottom: '2px solid #444', textAlign: 'left'}}>
            <th style={{padding: '10px'}}>Priority</th>
            <th style={{padding: '10px'}}>Type</th>
            <th style={{padding: '10px'}}>Bus</th>
            <th style={{padding: '10px'}}>Description</th>
            <th style={{padding: '10px'}}>Status</th>
            <th style={{padding: '10px'}}>Timestamp</th>
          </tr>
        </thead>
        <tbody>
          {alerts.map((alert) => (
            <tr key={alert.id} style={{borderBottom: '1px solid #333'}}>
              <td style={{padding: '10px'}}>{getSeverityLabel(alert.severity_level)}</td>
              <td style={{padding: '10px', textTransform: 'capitalize'}}>{alert.alert_type}</td>
              <td style={{padding: '10px'}}>{alert.buses?.bus_number || 'N/A'}</td>
              <td style={{padding: '10px'}}>{alert.description}</td>
              <td style={{padding: '10px'}}>
                <select 
                  value={alert.status} 
                  style={{background: '#222', color: '#fff', border: '1px solid #555'}}
                  onChange={async (e) => {
                    const { error } = await supabase
                      .from('emergency_alerts')
                      .update({ status: e.target.value })
                      .eq('id', alert.id);
                    if (error) console.error(error);
                  }}
                >
                  <option value="new">New</option>
                  <option value="responded">Responded</option>
                  <option value="resolved">Resolved</option>
                </select>
              </td>
              <td style={{padding: '10px'}}>{new Date(alert.created_at).toLocaleString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default EmergencyHandling;
