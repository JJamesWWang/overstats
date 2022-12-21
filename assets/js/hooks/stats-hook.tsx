import React, { PureComponent } from "react";
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
} from "recharts";

const StatsHook = {
  mounted() {
    let statsData;

    const element = document.getElementById("stats-hook");
    const root = createRoot(element);

    this.handleEvent("stats_data_updated", ({ data }) => {
      statsData = data;
      console.log(statsData);
      root.render(<StatsPage data={statsData.name} />);
    });
  },
};

const StatsPage = (props: StatsPageProps) => {
  return (
    <>
      <P>Winrate: {props.win_rate}</P>
      <WinRateByHeroChart data={props.win_rate_by_hero} />
    </>
  );
};

type StatsPageProps = {
  win_rate: number;
  win_rate_by_hero: WinRateByHeroData[];
};

const P = (props) => {
  return (
    <p className="leading-5 text-gray-600 dark:text-gray-400 mb-2">{props.children}</p>
  );
};

type WinRateByHeroData = {
  hero_name: string;
  competitive_win_rate: number;
  quick_play_win_rate: number;
};

const WinRateByHeroChart = (props: { data: WinRateByHeroData[] }) => {
  return (
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
        <XAxis dataKey="hero_name" />
        <YAxis />
        <Tooltip />
        <Legend />
        <Bar dataKey="competitive_win_rate" fill="#fb923c" />
        <Bar dataKey="quick_play_win_rate" fill="#818cf8" />
      </BarChart>
    </ResponsiveContainer>
  );
};
export default StatsHook;
