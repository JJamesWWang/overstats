import React from "react";
import { createRoot } from "react-dom/client";

const StatsPage = (props) => {
  return <P>{props.data ? props.data : "None"}</P>;
};

const P = (props) => {
  return (
    <p className="leading-5 text-gray-600 dark:text-gray-400 mb-2">{props.children}</p>
  );
};

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

export default StatsHook;
