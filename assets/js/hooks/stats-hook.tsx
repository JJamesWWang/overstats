import React from "react";
import { createRoot } from "react-dom/client";
import {
  BarChart,
  Bar,
  Cell,
  XAxis,
  YAxis,
  CartesianGrid,
  Tooltip,
  Legend,
  ResponsiveContainer,
  RadarChart,
  PolarGrid,
  PolarAngleAxis,
  PolarRadiusAxis,
  Radar,
} from "recharts";

const StatsHook = {
  mounted() {
    const element = document.getElementById("stats-hook");
    let root = createRoot(element);

    this.handleEvent("stats_data_updated", ({ data }) => {
      root.render(<StatsPage {...data} />);
    });
  },
};

const StatsPage = (props: StatsPageProps) => {
  console.log(props);
  return (
    <>
      <H4>Overall Winrate: {toPercent(props.win_rate)}</H4>

      <H4>Win rate by hero:</H4>
      <WinRateByHeroChart data={props.win_rate_by_hero} />

      <H4>Win rate by map:</H4>
      <WinRateByMapChart data={props.win_rate_by_map} />

      <H4>Win rate by map type:</H4>
      <WinRateByMapTypeChart data={props.win_rate_by_map_type} />

      <H4>Win rate by role:</H4>
      <WinRateByRoleChart data={props.win_rate_by_role} />

      <H4>Role selection bias:</H4>
      <RoleSelectionBiasChart data={props.role_selection_bias} />
    </>
  );
};

const toPercent = (decimal) => (decimal * 100).toFixed(2) + "%";

type StatsPageProps = {
  win_rate: number;
  win_rate_by_hero: WinRateByHeroData[];
  win_rate_by_map: WinRateByMapData[];
  win_rate_by_map_type: WinRateByMapTypeData[];
  win_rate_by_role: WinRateByRoleData[];
  role_selection_bias: RoleSelectionBiasData[];
  most_played_heroes: MostPlayedHeroesData[];
  most_played_maps: MostPlayedMapsData[];
};

const H4 = (props) => {
  return (
    <p className="text-l sm:text-xl font-bold leading-7 mt-4 text-gray-900 dark:text-white mb-5">
      {props.children}
    </p>
  );
};

type WinRateByHeroData = {
  hero: string;
  win_rate: number;
};

const WinRateByHeroChart = (props: { data: WinRateByHeroData[] }) => {
  return (
    <div style={{ height: "512px" }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart
          width={500}
          height={300}
          data={props.data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="hero" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="win_rate" fill="#fb923c" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

type WinRateByMapData = {
  map: string;
  win_rate: number;
};

const WinRateByMapChart = (props: { data: WinRateByMapData[] }) => {
  return (
    <div style={{ height: "512px" }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart
          width={500}
          height={300}
          data={props.data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="map" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="win_rate" fill="#fb923c" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

type WinRateByMapTypeData = {
  map_type: string;
  win_rate: number;
};

const WinRateByMapTypeChart = (props: { data: WinRateByMapTypeData[] }) => {
  return (
    <div style={{ height: "512px" }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart
          width={500}
          height={300}
          data={props.data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="map_type" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="win_rate" fill="#fb923c" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

type WinRateByRoleData = {
  role: string;
};

const WinRateByRoleChart = (props: { data: WinRateByRoleData[] }) => {
  return (
    <div style={{ height: "512px" }}>
      <ResponsiveContainer width="100%" height="100%">
        <BarChart
          width={500}
          height={300}
          data={props.data}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <CartesianGrid strokeDasharray="3 3" />
          <XAxis dataKey="role" />
          <YAxis />
          <Tooltip />
          <Legend />
          <Bar dataKey="win_rate" fill="#fb923c" />
        </BarChart>
      </ResponsiveContainer>
    </div>
  );
};

type RoleSelectionBiasData = {
  role: string;
  count: number;
  fullMark: number;
};

const RoleSelectionBiasChart = (props: { data: RoleSelectionBiasData[] }) => {
  return (
    <div style={{ height: "512px" }}>
      <ResponsiveContainer width="100%" height="100%">
        <RadarChart cx="50%" cy="50%" outerRadius="80%" data={props.data}>
          <PolarGrid />
          <PolarAngleAxis dataKey="role" />
          <PolarRadiusAxis />
          <Radar
            name="All"
            dataKey="count"
            stroke="#fb923c"
            fill="#fb923c"
            fillOpacity={0.6}
          />
        </RadarChart>
      </ResponsiveContainer>
    </div>
  );
};

type MostPlayedHeroesData = {};

const MostPlayedHeroesChart = (props: { data: MostPlayedHeroesData[] }) => {};

type MostPlayedMapsData = {};

const MostPlayedMapsChart = (props: { data: MostPlayedMapsData[] }) => {};

export default StatsHook;
